def zig_cxx_toolchain(name, target, zig_dist):
    cxx_toolchain(
        name = name,
        compiler_type = "clang",
        target = target,
        linker_type = "gnu",
        binary_extension = ".exe" if "windows" in target else "",
        compiler = "$(location {})/zig cc".format(zig_dist),
        compiler_flags = [
            "-target", target,
            "-fuse-ld=lld",
        ],
        linker = "$(location {})/zig cc".format(zig_dist),
        linker_flags = [
            "-target", target,
            "-fuse-ld=lld",
        ],
        archiver = "$(location {})/zig ar".format(zig_dist),
        archiver_flags = ["rcs"],
        ranlib = "$(location {})/zig ranlib".format(zig_dist),
        strip = "$(location {})/zig strip".format(zig_dist),
    )