load("@rules_sphinx//sphinx:defs.bzl", "sphinx_html")

genrule(
    name = "generated_gen",
    srcs = ["gen_source.rst"],
    outs = ["generated.rst"],
    cmd = "cp $< $@",
)

sphinx_html(
    name = "test_docs",
    config = "conf.py",
    srcs = [
        "index.rst",
        "generated.rst",
        "//test/subdir:test_file.rst",
    ],
)
