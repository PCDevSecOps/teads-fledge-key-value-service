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

load("@emsdk//emscripten_toolchain:wasm_rules.bzl", "wasm_cc_binary")
load("@rules_cc//cc:defs.bzl", "cc_binary")

EMSCRIPTEN_FLAGS = [
    "--no-entry",  # no main function
    "-O3",  # optimization
    "-sSTANDALONE_WASM",  # standalone wasm w/o needing javascript wrappers
]

cc_binary(
    name = "add",
    srcs = ["add.cc"],
    linkopts = EMSCRIPTEN_FLAGS,
)

# build target for wasm binary
wasm_cc_binary(
    name = "add_wasm",
    cc_target = ":add",
)
