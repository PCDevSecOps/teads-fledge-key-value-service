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

variable "service" {
  description = "Assigned name of the KV server."
  type        = string
}

variable "environment" {
  description = "Assigned environment name to group related resources."
  type        = string
}

variable "autoscaling_desired_capacity" {
  type = number
}

variable "autoscaling_max_size" {
  type = number
}

variable "autoscaling_min_size" {
  type    = number
  default = 0
}

variable "autoscaling_subnet_ids" {
  type = list(string)
}

variable "instance_ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_security_group_id" {
  type = string
}

variable "instance_profile_arn" {
  description = "Profile to attach to instances when they are launched."
  type        = string
}

variable "target_group_arns" {
  type = list(string)
}

variable "enclave_memory_mib" {
  description = "Amount of memory to allocate to the enclave."
  type        = number
}

variable "enclave_cpu_count" {
  description = "The number of vcpus to allocate to the enclave."
  type        = number
}

variable "server_port" {
  description = "Port on which the enclave listens for TCP connections."
  type        = number
}

variable "launch_hook_name" {
  description = "Launch hook name"
  type        = string
}

variable "region" {
  description = "AWS region to deploy to."
  type        = string
}

variable "prometheus_service_region" {
  description = "All parameters related to AWS region setup for specific services"
  type        = string
  validation {
    condition     = var.prometheus_service_region != ""
    error_message = "Please set var.prometheus_service_region. See https://docs.aws.amazon.com/general/latest/gr/prometheus-service.html for supported regions."
  }
}

variable "prometheus_workspace_id" {
  description = "Workspace ID created for this environment."
  type        = string
}

variable "shard_num" {
  description = "Shard number."
  type        = string
}

variable "wait_for_capacity_timeout" {
  description = "Wait for ASG capacity timeout"
  type        = string
}

locals {
  validate_prometheus_workspace_id = (
  var.prometheus_service_region == var.region || var.prometheus_workspace_id != null) ? true : tobool("If Prometheus service runs in a different region, please create the workspace first and specify the workspace id in var file.")
}
