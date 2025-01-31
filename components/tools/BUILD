# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_image",
    "container_layer",
)
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")

pkg_tar(
    name = "data_loading_analyzer_binaries",
    srcs = [
        ":data_loading_analyzer",
        "@control_plane_shared//cc/aws/proxy/src:proxify",
        "@control_plane_shared//cc/aws/proxy/src:proxy_preload",
        "@control_plane_shared//cc/aws/proxy/src:socket_vendor",
    ],
    package_dir = "/opt/privacysandbox/bin",
)

container_layer(
    name = "data_loading_analyzer_layer",
    directory = "/",
    tars = [
        ":data_loading_analyzer_binaries",
    ],
)

# This image target is meant for testing running the server in an enclave using.
#
# See project README.md on how to run the image.
container_image(
    name = "data_loading_analyzer_enclave_image",
    base = select({
        "@platforms//cpu:arm64": "@runtime-debian-arm64//image",
        "@platforms//cpu:x86_64": "@runtime-debian-amd64//image",
    }),
    cmd = [
        "/opt/privacysandbox/bin/proxify",
        "/opt/privacysandbox/bin/data_loading_analyzer",
    ],
    entrypoint = ["/bin/bash"],
    layers = [
        ":data_loading_analyzer_layer",
    ],
)

cc_binary(
    name = "data_loading_analyzer",
    srcs = ["data_loading_analyzer.cc"],
    visibility = ["//production/packaging:__subpackages__"],
    deps = [
        "//components/data/blob_storage:blob_storage_client",
        "//components/data/blob_storage:delta_file_notifier",
        "//components/data_server/cache",
        "//components/data_server/cache:key_value_cache",
        "//components/data_server/data_loading:data_orchestrator",
        "//components/udf:noop_udf_client",
        "//components/util:platform_initializer",
        "//public:base_types_cc_proto",
        "//public/data_loading:data_loading_fbs",
        "//public/data_loading/readers:riegeli_stream_io",
        "@com_github_google_flatbuffers//:flatbuffers",
        "@com_github_google_glog//:glog",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/strings",
        "@google_privacysandbox_servers_common//src/cpp/telemetry:metrics_recorder",
        "@google_privacysandbox_servers_common//src/cpp/telemetry:telemetry_provider",
    ],
)

cc_binary(
    name = "blob_storage_change_watcher",
    srcs = select({
        "//:aws_platform": [
            "blob_storage_change_watcher_aws.cc",
        ],
        "//:local_platform": [
            "blob_storage_change_watcher_local.cc",
        ],
    }),
    deps = [
        "//components/data/blob_storage:blob_storage_change_notifier",
        "//components/util:platform_initializer",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/flags:usage",
    ],
)

cc_library(
    name = "blob_storage_commands",
    srcs = ["blob_storage_commands.cc"],
    hdrs = ["blob_storage_commands.h"],
    deps = [
        "//components/data/blob_storage:blob_storage_client",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/status:statusor",
    ],
)

cc_binary(
    name = "blob_storage_util",
    srcs = select({
        "//:aws_platform": [
            "blob_storage_util_aws.cc",
        ],
        "//:local_platform": [
            "blob_storage_util_local.cc",
        ],
    }),
    deps = [
        ":blob_storage_commands",
        "//components/data/blob_storage:blob_storage_client",
        "//components/util:platform_initializer",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/flags:usage",
    ],
)

cc_binary(
    name = "delta_file_watcher",
    srcs = select({
        "//:aws_platform": [
            "delta_file_watcher_aws.cc",
        ],
        "//:local_platform": [
            "delta_file_watcher_local.cc",
        ],
    }),
    deps = [
        "//components/data/blob_storage:blob_storage_client",
        "//components/data/blob_storage:delta_file_notifier",
        "//components/data/common:thread_manager",
        "//components/util:platform_initializer",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/flags:usage",
    ],
)

cc_binary(
    name = "delta_file_record_change_watcher",
    srcs = [
        "delta_file_record_change_watcher.cc",
    ],
    deps = [
        "//components/data/realtime:delta_file_record_change_notifier",
        "//components/util:platform_initializer",
        "//public/data_loading:data_loading_fbs",
        "//public/data_loading:filename_utils",
        "//public/data_loading:records_utils",
        "//public/data_loading/readers:riegeli_stream_io",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/flags:usage",
        "@com_google_absl//absl/strings",
    ],
)

cc_binary(
    name = "get_region",
    srcs = select({
        "//:aws_platform": ["get_region_aws.cc"],
        "//:local_platform": ["get_region_local.cc"],
    }),
    visibility = ["//production/packaging:__subpackages__"],
    deps = select({
        "//:aws_platform": [
            "//components/errors:aws_error_util",
            "@aws_sdk_cpp//:core",
            "@aws_sdk_cpp//:ec2",
            "@com_github_google_glog//:glog",
            "@com_google_absl//absl/cleanup",
            "@com_google_absl//absl/flags:flag",
            "@com_google_absl//absl/flags:parse",
            "@com_google_absl//absl/status:statusor",
            "@com_google_absl//absl/strings",
        ],
        "//:local_platform": [
            "@com_github_google_glog//:glog",
        ],
    }),
)

cc_binary(
    name = "realtime_updates_publisher",
    srcs = ["realtime_updates_publisher.cc"],
    visibility = ["//production/packaging:__subpackages__"],
    deps = [
        "//components/errors:aws_error_util",
        "//components/util:platform_initializer",
        "//public/data_loading:filename_utils",
        "@aws_sdk_cpp//:sns",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/strings",
    ],
)

cc_binary(
    name = "query_toy",
    srcs = ["query_toy.cc"],
    visibility = ["//production/packaging:__subpackages__"],
    deps = [
        "//components/query:driver",
        "//components/query:scanner",
        "@com_google_absl//absl/container:flat_hash_map",
        "@com_google_absl//absl/container:flat_hash_set",
        "@com_google_absl//absl/flags:flag",
        "@com_google_absl//absl/flags:parse",
        "@com_google_absl//absl/strings",
    ],
)
