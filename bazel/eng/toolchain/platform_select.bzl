load("@bazel_skylib//lib:selects.bzl", "selects")

def get_target_compatible_with(platform):
    parts = platform.split("-")
    cpu = parts[0]
    os = parts[-2] if len(parts) >= 3 else parts[-1]

    os_constraint = "@platforms//os:" + ("macos" if os == "apple" else os)
    cpu_constraint = "@platforms//cpu:" + cpu

    return [os_constraint, cpu_constraint]

def platform_select(name, platforms):
    return select({
        ":platform_" + platform: ":" + name + "_" + platform
        for platform in platforms
    })

def declare_config_settings(platforms):
    for platform in platforms:
        native.config_setting(
            name = "platform_" + platform,
            constraint_values = get_target_compatible_with(platform),
        )
