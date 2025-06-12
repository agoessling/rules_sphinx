# rules_sphinx

Rules for building [Sphinx](https://www.sphinx-doc.org/en/master/) documentation with
[Bazel](https://bazel.build/).

## Installation

To incorporate `rules_sphinx` into your bzlmod project, add the following to your `MODULE.bazel` file.

```starlark
# See release page for latest version
bazel_dep(name = "rules_sphinx", version = "0.0.0")
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
