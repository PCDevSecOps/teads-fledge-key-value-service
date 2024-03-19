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

# Setup security groups for various network components.
#
# NOTE that security group rules are managed in "../security_group_rules" module.

# Security group to control ingress and egress traffic for the load balancer.
resource "aws_security_group" "elb_security_group" {
  name   = "${var.service}-${var.environment}-elb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.service}-${var.environment}-elb-sg"
    service     = var.service
    environment = var.environment
    yor_trace   = "66ca8868-c6ba-4866-a086-e81f0a3d9e22"
  }
}

# Security group to control ingress and egress traffic for the ssh ec2 instance.
resource "aws_security_group" "ssh_security_group" {
  name   = "${var.service}-${var.environment}-ssh-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.service}-${var.environment}-ssh-sg"
    service     = var.service
    environment = var.environment
    yor_trace   = "8b3265ec-55fa-478f-87eb-2c7c9a8de1d6"
  }
}

# Security group to control ingress and egress traffic for the server ec2 instances.
resource "aws_security_group" "instance_security_group" {
  name   = "${var.service}-${var.environment}-instance-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.service}-${var.environment}-instance-sg"
    service     = var.service
    environment = var.environment
    yor_trace   = "2c9f1a0e-36e7-4a4d-8a70-a08b97f40bcb"
  }
}

# Security group to control ingress and egress traffic to backend vpc endpoints.
resource "aws_security_group" "vpce_security_group" {
  name   = "${var.service}-${var.environment}-vpce-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.service}-${var.environment}-vpce-sg"
    service     = var.service
    environment = var.environment
    yor_trace   = "6b05d626-c653-4540-877a-143885e8b836"
  }
}
