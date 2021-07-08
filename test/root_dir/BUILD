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
    index = "test_index.rst",  # Test non-canonical naming.
    srcs = [
        "generated.rst",
        "//test/root_dir/subdir:test_file.rst",
        "//test:external_file.txt",
    ],
)
