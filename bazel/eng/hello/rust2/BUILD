load("@rules_rust//rust:defs.bzl", "rust_binary")
package(default_visibility = ["//visibility:public"])

rust_binary(
    name = "x",
    srcs = ["src/main.rs"],
    deps = ["//eng/hello/rust:hello_lib"],
)