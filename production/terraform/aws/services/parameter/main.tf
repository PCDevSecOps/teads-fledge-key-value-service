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

resource "aws_ssm_parameter" "mode_parameter" {
  name      = "${var.service}-${var.environment}-mode"
  type      = "String"
  value     = var.mode_parameter_value
  overwrite = true
  tags = {
    yor_trace = "baa455c9-a0d1-4dd8-abce-67b0f3be1687"
  }
}

resource "aws_ssm_parameter" "s3_bucket_parameter" {
  name      = "${var.service}-${var.environment}-data-bucket-id"
  type      = "String"
  value     = var.s3_bucket_parameter_value
  overwrite = true
  tags = {
    yor_trace = "514ab82f-e53e-47ef-a44c-6a451b5c8676"
  }
}

resource "aws_ssm_parameter" "bucket_update_sns_arn_parameter" {
  name      = "${var.service}-${var.environment}-data-loading-file-channel-bucket-sns-arn"
  type      = "String"
  value     = var.bucket_update_sns_arn_parameter_value
  overwrite = true
  tags = {
    yor_trace = "28853712-5ac7-4b82-ae2e-faa635845798"
  }
}

resource "aws_ssm_parameter" "realtime_sns_arn_parameter" {
  name      = "${var.service}-${var.environment}-data-loading-realtime-channel-sns-arn"
  type      = "String"
  value     = var.realtime_sns_arn_parameter_value
  overwrite = true
  tags = {
    yor_trace = "bcaba644-cc7d-468b-899f-faa46cb9ba8a"
  }
}

resource "aws_ssm_parameter" "launch_hook_parameter" {
  name      = "${var.service}-${var.environment}-launch-hook"
  type      = "String"
  value     = "${var.service}-${var.environment}-launch-hook"
  overwrite = true
  tags = {
    yor_trace = "0327a82c-a5f7-4bbc-b9a1-a61ff884eea6"
  }
}

resource "aws_ssm_parameter" "backup_poll_frequency_secs_parameter" {
  name      = "${var.service}-${var.environment}-backup-poll-frequency-secs"
  type      = "String"
  value     = var.backup_poll_frequency_secs_parameter_value
  overwrite = true
  tags = {
    yor_trace = "8f404bb3-4d82-4ac4-9e94-a1ede6c474b5"
  }
}

resource "aws_ssm_parameter" "metrics_export_interval_millis_parameter" {
  name      = "${var.service}-${var.environment}-metrics-export-interval-millis"
  type      = "String"
  value     = var.metrics_export_interval_millis_parameter_value
  overwrite = true
  tags = {
    yor_trace = "14fbbb86-6a88-41a3-bc33-e455decc4f7a"
  }
}

resource "aws_ssm_parameter" "metrics_export_timeout_millis_parameter" {
  name      = "${var.service}-${var.environment}-metrics-export-timeout-millis"
  type      = "String"
  value     = var.metrics_export_timeout_millis_parameter_value
  overwrite = true
  tags = {
    yor_trace = "d65b2474-f3c0-4266-85ea-66dc13a5da81"
  }
}

resource "aws_ssm_parameter" "realtime_updater_num_threads_parameter" {
  name      = "${var.service}-${var.environment}-realtime-updater-num-threads"
  type      = "String"
  value     = var.realtime_updater_num_threads_parameter_value
  overwrite = true
  tags = {
    yor_trace = "a3c1677c-2fee-4dee-9970-d55baac13fa2"
  }
}

resource "aws_ssm_parameter" "data_loading_num_threads_parameter" {
  name      = "${var.service}-${var.environment}-data-loading-num-threads"
  type      = "String"
  value     = var.data_loading_num_threads_parameter_value
  overwrite = true
  tags = {
    yor_trace = "f5c26f4b-eb17-4082-b2c5-d216142a94dd"
  }
}

resource "aws_ssm_parameter" "s3client_max_connections_parameter" {
  name      = "${var.service}-${var.environment}-s3client-max-connections"
  type      = "String"
  value     = var.s3client_max_connections_parameter_value
  overwrite = true
  tags = {
    yor_trace = "fe8d5173-61f7-4f52-b538-d2e62f3ff59a"
  }
}

resource "aws_ssm_parameter" "s3client_max_range_bytes_parameter" {
  name      = "${var.service}-${var.environment}-s3client-max-range-bytes"
  type      = "String"
  value     = var.s3client_max_range_bytes_parameter_value
  overwrite = true
  tags = {
    yor_trace = "d099b619-03c2-494c-bfce-052341cd9942"
  }
}

resource "aws_ssm_parameter" "num_shards_parameter" {
  name      = "${var.service}-${var.environment}-num-shards"
  type      = "String"
  value     = var.num_shards_parameter_value
  overwrite = true
  tags = {
    yor_trace = "6ee48f01-cb3f-4745-9e5e-128b441b6d79"
  }
}

resource "aws_ssm_parameter" "udf_num_workers_parameter" {
  name      = "${var.service}-${var.environment}-udf-num-workers"
  type      = "String"
  value     = var.udf_num_workers_parameter_value
  overwrite = true
  tags = {
    yor_trace = "6c3553f2-35c8-4ace-a5c8-5da402d2f99d"
  }
}

resource "aws_ssm_parameter" "route_v1_requests_to_v2_parameter" {
  name      = "${var.service}-${var.environment}-route-v1-to-v2"
  type      = "String"
  value     = var.route_v1_requests_to_v2_parameter_value
  overwrite = true
  tags = {
    yor_trace = "e7503066-def5-4915-82e2-18d75053478a"
  }
}
