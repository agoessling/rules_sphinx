load("@rules_python//python:defs.bzl", "py_binary")

load("@pip_deps//:requirements.bzl", "requirement")

py_binary(
    name = "sphinx_build_wrapper",
    srcs = ["sphinx_build_wrapper.py"],
    deps = [
        requirement("sphinx"),
        requirement("sphinx_rtd_theme"),
    ],
    visibility = ["//visibility:public"],
)
