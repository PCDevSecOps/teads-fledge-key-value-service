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

####################################################
# Create EC2 instance profile.
####################################################
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "ec2.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = format("%s-%s-InstanceRole", var.service, var.environment)
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    Name        = format("%s-%s-InstanceRole", var.service, var.environment)
    service     = var.service
    environment = var.environment
    yor_trace   = "83669667-5c0f-48f7-aa58-3160937f55fe"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = format("%s-%s-InstanceProfile", var.service, var.environment)
  role = aws_iam_role.instance_role.name

  tags = {
    Name        = format("%s-%s-InstanceProfile", var.service, var.environment)
    service     = var.service
    environment = var.environment
    yor_trace   = "b74ab95e-0bad-48a8-81ec-d8a5611c01fe"
  }
}

####################################################
# Create SSH role for using EC2 instance connect.
####################################################
resource "aws_iam_role" "ssh_instance_role" {
  name               = format("%s-%s-sshInstanceRole", var.service, var.environment)
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    Name        = format("%s-%s-sshInstanceRole", var.service, var.environment)
    service     = var.service
    environment = var.environment
    yor_trace   = "616d1cf0-9f74-4d92-bdf9-28742551643f"
  }
}

resource "aws_iam_instance_profile" "ssh_instance_profile" {
  name = format("%s-%s-sshInstanceProfile", var.service, var.environment)
  role = aws_iam_role.ssh_instance_role.name

  tags = {
    Name        = format("%s-%s-sshInstanceProfile", var.service, var.environment)
    service     = var.service
    environment = var.environment
    yor_trace   = "8f28c4fc-4c19-437a-99ae-004252817831"
  }
}

####################################################
# Create Lambda role required for SQS cleanup.
####################################################
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "lambda.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = format("%s-%s-LambdaRole", var.service, var.environment)
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = {
    Name        = format("%s-%s-LambdaRole", var.service, var.environment)
    service     = var.service
    environment = var.environment
    yor_trace   = "0f56f028-8747-469b-97cd-960f665487ae"
  }
}
