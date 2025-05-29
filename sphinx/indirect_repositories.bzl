load("@rules_python//python:pip.bzl", "pip_parse")

def rules_sphinx_indirect_deps():
    pip_parse(
        name = "pip_deps",
        requirements_lock = "@rules_sphinx//sphinx/tools:requirements.txt",
    )
