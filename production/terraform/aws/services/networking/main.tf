/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

################################################################################
# Setup VPC, and networking for private subnets and public subnets.
################################################################################

# Create the VPC where server instances will be launched.
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.service}-${var.environment}-vpc"
    service     = var.service
    environment = var.environment
    yor_trace   = "4f036c47-69ad-4c19-a322-5c6bce298275"
  }
}

# Get information about available AZs.
data "aws_availability_zones" "azs" {
  state = "available"
}

# Create public subnets used to connect to instances in private subnets.
resource "aws_subnet" "public_subnet" {
  count                   = length(data.aws_availability_zones.azs.names)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.service}-${var.environment}-public-subnet${count.index}"
    service     = var.service
    environment = var.environment
    yor_trace   = "5215e4d7-c88e-463b-abb0-9c7765b52de7"
  }
}

# Create private subnets where instances will be launched.
resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.azs.names)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 15 - count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.service}-${var.environment}-private-subnet${count.index}"
    service     = var.service
    environment = var.environment
    yor_trace   = "1177975f-7fee-430f-b7d2-f036b63932ca"
  }
}

# Create networking components for public subnets.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.service}-${var.environment}-igw"
    service     = var.service
    environment = var.environment
    yor_trace   = "68b28740-1c91-4ab2-af24-49d911c9903f"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.service}-${var.environment}-public-rt"
    service     = var.service
    environment = var.environment
    yor_trace   = "676fcad0-0ae5-4f83-9d29-4b6e5559ceaa"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Create private route tables required for gateway endpoints.
resource "aws_route_table" "private_rt" {
  count  = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.service}-${var.environment}-private-rt${count.index}"
    service     = var.service
    environment = var.environment
    yor_trace   = "608af5a8-f393-4a0f-af2d-49db3a8ae7f0"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnet)
  route_table_id = aws_route_table.private_rt[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
