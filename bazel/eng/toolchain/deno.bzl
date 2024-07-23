load(
    "@aspect_rules_deno//deno:repositories.bzl",
    "LATEST_VERSION",
    "deno_register_toolchains",
    "rules_deno_dependencies",
)

def _deno_setup(ctx):
    # Fetches the rules_deno dependencies.
    rules_deno_dependencies()
    # Register the Deno toolchains with the latest version.
    deno_register_toolchains(
        name = "deno",
        deno_version = LATEST_VERSION,
    )

deno_setup = module_extension(implementation = _deno_setup)