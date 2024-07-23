platform(
    name = "linux_x64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

platform(
    name = "linux_arm64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
)

platform(
    name = "darwin_x64",
    constraint_values = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64",
    ],
)

platform(
    name = "darwin_arm64",
    constraint_values = [
        "@platforms//os:macos",
        "@platforms//cpu:aarch64",
    ],
)

platform(
    name = "windows_x64",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
)


######################
# rules_deno setup #
######################

# load(
#     "@aspect_rules_deno//deno:repositories.bzl",
#     "LATEST_VERSION",
#     "deno_register_toolchains",
#     "rules_deno_dependencies",
# )

# # Fetches the rules_deno dependencies.
# # If you want to have a different version of some dependency,
# # you should fetch it *before* calling this.
# # Alternatively, you can skip calling this function, so long as you've
# # already fetched all the dependencies.
# rules_deno_dependencies()

# deno_register_toolchains(
#     name = "deno",
#     deno_version = LATEST_VERSION,
# )