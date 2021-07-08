# rules_sphinx

Rules for building [Sphinx](https://www.sphinx-doc.org/en/master/) documentation with
[Bazel](https://bazel.build/).

## WORKSPACE
To incorporate `rules_sphinx` into your project at the following to your `WORKSPACE` file.

```Starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_sphinx",
    # See release page for latest version url and sha.
)
```

## Rules

* `sphinx_html_gen` - Generates HTML documentation into `[NAME]_html` directory.
* `sphinx_view` - Given an HTML generator, create target to launch viewer.
* `sphinx_html` - A macro that creates a `sphinx_html_gen` and an associated `sphinx_view` with the
  `[NAME].view` verb.

## Examples

To build the test documentation use:

```Shell
bazel build @rules_sphinx//test:test_docs
```

To build and view test documentation use:

```Shell
bazel run @rules_sphinx//test:test_docs.view
```
