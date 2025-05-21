load("@rules_python//python:defs.bzl", "py_binary")
load("@rules_python//python/pip_install:requirements.bzl", "compile_pip_requirements")

load("@pip_deps//:requirements.bzl", "requirement")

compile_pip_requirements(
    name = "requirements",
    requirements_in = "requirements.in",
    requirements_txt = "requirements.txt",
)

exports_files(["sphinx_build_wrapper.py"])

py_binary(
    name = "sphinx_build_wrapper",
    srcs = ["sphinx_build_wrapper.py"],
    deps = [
        requirement("sphinx"),
        requirement("sphinx_rtd_theme"),
    ],
    visibility = ["//visibility:public"],
)
