load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def _repo_deps(ctx):
    http_archive(
        name = "llvm_project",
        strip_prefix = "llvm-project-18.1.0.src",
        sha256 = "758a048046ac5024f86c868bb17c631500eed8f8d2677ae6a72ab7ad01602277",
        urls = ["https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.0/llvm-project-18.1.0.src.tar.xz"],
    )

    http_archive(
        name = "aspect_rules_deno",
        sha256 = "cfda7aeb308082a4525f391b66e81d4f15bd05c3f0a5131e4645e74ea1e32760",
        strip_prefix = "rules_deno-0.3.0",
        url = "https://github.com/aspect-build/rules_deno/archive/refs/tags/v0.3.0.tar.gz",
    )

repo_deps = module_extension(_repo_deps)

