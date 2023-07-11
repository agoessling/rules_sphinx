load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def rules_sphinx_direct_deps():
    http_archive(
        name = "bazel_skylib",
        url = "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.2/bazel-skylib-1.4.2.tar.gz",
        sha256 = "66ffd9315665bfaafc96b52278f57c7e2dd09f5ede279ea6d39b2be471e7e3aa",
    )

    http_archive(
        name = "rules_python",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
        sha256 = "778197e26c5fbeb07ac2a2c5ae405b30f6cb7ad1f5510ea6fdac03bded96cc6f",
    )
