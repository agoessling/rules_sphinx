# rules_sphinx

Rules for building [Sphinx](https://www.sphinx-doc.org/en/master/) documentation with
[Bazel](https://bazel.build/).

## Installation

### WORKSPACE
To incorporate `rules_sphinx` into your project at the following to your `WORKSPACE` file.

```Starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_sphinx",
    # See release page for latest version url and sha.
)

load("@rules_sphinx//sphinx:direct_repositories.bzl", "rules_sphinx_direct_deps")
rules_sphinx_direct_deps()

load("@rules_sphinx//sphinx:indirect_repositories.bzl", "rules_sphinx_indirect_deps")
rules_sphinx_indirect_deps()
```

## Usage

### Rules

* `sphinx_html_gen` - Generates HTML documentation into `[NAME]_html` directory.
* `sphinx_view` - Given an HTML generator, create target to launch viewer.
* `sphinx_html` - A macro that creates a `sphinx_html_gen` and an associated `sphinx_view` with the
`[NAME].view` verb.

### Customizing sphinx runtime environment

By default, only `sphinx` and `sphinx_rtd_theme` are available in the environment. To include other dependencies (e.g. sphinx extensions), do the following:

```starlark
load("@your_pypi_deps//:requirements.bzl", "requirement")

py_binary(
    name = "sphinx_build",
    srcs = ["@rules_sphinx//sphinx/tools:sphinx_build_wrapper.py"],
    main = "sphinx_build_wrapper.py",
    deps = [
        requirement("sphinx"),
        # add your sphinx dependencies here
    ],
)
```

Then in `sphinx_html` or `sphinx_html_gen`, include `sphinx_build = ":sphinx_build"`.

## Examples

To build the test documentation use:

```shell
bazel build @rules_sphinx//test/root_dir:test_docs
```

To build and view test documentation use:

```shell
bazel run @rules_sphinx//test/root_dir:test_docs.view
```
