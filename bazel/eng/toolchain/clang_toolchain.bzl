load("@rules_cc//cc:defs.bzl", "cc_toolchain")

def _clang_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        clang_binary = ctx.file.clang_binary,
        libcxx = ctx.attr.libcxx,
        libcxxabi = ctx.attr.libcxxabi,
        compiler_rt = ctx.attr.compiler_rt,
        libunwind = ctx.attr.libunwind,
        openmp = ctx.attr.openmp,
        target_cpu = ctx.attr.target_cpu,
        target_libc = ctx.attr.target_libc,
        compiler = ctx.attr.compiler,
        abi_version = ctx.attr.abi_version,
        abi_libc_version = ctx.attr.abi_libc_version,
    )
    return [toolchain_info]

clang_toolchain = rule(
    implementation = _clang_toolchain_impl,
    attrs = {
        "clang_binary": attr.label(mandatory = True, allow_single_file = True),
        "libcxx": attr.label(mandatory = True),
        "libcxxabi": attr.label(mandatory = True),
        "compiler_rt": attr.label(mandatory = True),
        "libunwind": attr.label(mandatory = True),
        "openmp": attr.label(mandatory = True),
        "target_cpu": attr.string(mandatory = True),
        "target_libc": attr.string(mandatory = True),
        "compiler": attr.string(mandatory = True),
        "abi_version": attr.string(mandatory = True),
        "abi_libc_version": attr.string(mandatory = True),
    },
)

def register_clang_toolchain(name, clang_binary, libcxx, libcxxabi, compiler_rt, libunwind, openmp, target_cpu, target_libc, compiler, abi_version, abi_libc_version):
    native.toolchain(
        name = name + "_toolchain",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        exec_compatible_with = [
            "@platforms//cpu:" + target_cpu,
            "@platforms//os:" + target_libc,
        ],
        target_compatible_with = [
            "@platforms//cpu:" + target_cpu,
            "@platforms//os:" + target_libc,
        ],
        toolchain = ":" + name,
    )

    clang_toolchain(
        name = name,
        clang_binary = clang_binary,
        libcxx = libcxx,
        libcxxabi = libcxxabi,
        compiler_rt = compiler_rt,
        libunwind = libunwind,
        openmp = openmp,
        target_cpu = target_cpu,
        target_libc = target_libc,
        compiler = compiler,
        abi_version = abi_version,
        abi_libc_version = abi_libc_version,
    )

