load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load(":platform_select.bzl", "platform_select", "get_target_compatible_with", "declare_config_settings")
load(":clang_toolchain.bzl", "register_clang_toolchain")

PLATFORMS = [
    "x86_64-unknown-linux-gnu",
    "aarch64-unknown-linux-gnu",
    "x86_64-pc-windows-gnu",
    "x86_64-apple-darwin",
    "arm64-apple-darwin",
]

declare_config_settings(PLATFORMS)

[cc_binary(
    name = "clang_" + platform,
    srcs = glob([
        "$(llvm_project)/clang/lib/**/*.cpp",
        "$(llvm_project)/clang/tools/driver/*.cpp",
        "$(llvm_project)/clang/tools/clang-fuzzer/*.cpp",
        "$(llvm_project)/clang/include/**/*.h",
    ]),
    includes = ["$(llvm_project)/clang/include"],
    deps = [
        ":llvm_libs_" + platform,
        "@llvm_project//clang:Basic",
        "@llvm_project//clang:CodeGen",
        "@llvm_project//clang:Driver",
        "@llvm_project//clang:Frontend",
        "@llvm_project//clang:Lex",
        "@llvm_project//clang:Parse",
        "@llvm_project//clang:Sema",
        "@llvm_project//clang:Analysis",
        "@llvm_project//clang:AST",
        "@llvm_project//clang:Rewrite",
        "@llvm_project//clang:Edit",
    ],
    copts = ["-std=c++17", "-fno-exceptions", "-fno-rtti", "-DLLVM_ON_UNIX", "-DLLVM_VERSION_STRING=\\'18.1.0\\'"],
    linkopts = ["-ldl", "-lpthread", "-lm"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[cc_library(
    name = "libcxx_" + platform,
    srcs = glob(["$(llvm_project)/libcxx/src/**/*.cpp"]),
    hdrs = glob(["$(llvm_project)/libcxx/include/**/*.h"]),
    includes = ["$(llvm_project)/libcxx/include"],
    copts = ["-std=c++17"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[cc_library(
    name = "libcxxabi_" + platform,
    srcs = glob(["$(llvm_project)/libcxxabi/src/**/*.cpp"]),
    hdrs = glob(["$(llvm_project)/libcxxabi/include/**/*.h"]),
    includes = ["$(llvm_project)/libcxxabi/include"],
    deps = [":libcxx_" + platform],
    copts = ["-std=c++17"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[cc_library(
    name = "compiler_rt_" + platform,
    srcs = glob(["$(llvm_project)/compiler-rt/lib/**/*.cpp"]),
    hdrs = glob(["$(llvm_project)/compiler-rt/include/**/*.h"]),
    includes = ["$(llvm_project)/compiler-rt/include"],
    copts = ["-std=c++17"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[cc_library(
    name = "libunwind_" + platform,
    srcs = glob(["$(llvm_project)/libunwind/src/**/*.cpp"]),
    hdrs = glob(["$(llvm_project)/libunwind/include/**/*.h"]),
    includes = ["$(llvm_project)/libunwind/include"],
    copts = ["-std=c++17"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[cc_library(
    name = "openmp_" + platform,
    srcs = glob(["$(llvm_project)/openmp/runtime/src/**/*.cpp"]),
    hdrs = glob(["$(llvm_project)/openmp/runtime/src/**/*.h"]),
    includes = ["$(llvm_project)/openmp/runtime/src"],
    copts = ["-std=c++17"],
    target_compatible_with = get_target_compatible_with(platform),
) for platform in PLATFORMS]

[register_clang_toolchain(
    name = "clang_toolchain_" + platform,
    clang_binary = ":clang_" + platform,
    libcxx = ":libcxx_" + platform,
    libcxxabi = ":libcxxabi_" + platform,
    compiler_rt = ":compiler_rt_" + platform,
    libunwind = ":libunwind_" + platform,
    openmp = ":openmp_" + platform,
    target_cpu = platform.split("-")[0],
    target_libc = "glibc" if "linux" in platform else "macosx" if "apple" in platform else "msvcrt",
    compiler = "clang",
    abi_version = "local",
    abi_libc_version = "local",
) for platform in PLATFORMS]

platform_select(name = "clang", platforms = PLATFORMS)
platform_select(name = "libcxx", platforms = PLATFORMS)
platform_select(name = "libcxxabi", platforms = PLATFORMS)
platform_select(name = "compiler_rt", platforms = PLATFORMS)
platform_select(name = "libunwind", platforms = PLATFORMS)
platform_select(name = "openmp", platforms = PLATFORMS)
