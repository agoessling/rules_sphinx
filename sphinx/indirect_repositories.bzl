load("@rules_python//python:pip.bzl", "pip_install")

def rules_sphinx_indirect_deps():
    pip_install(
        name = "pip_deps",
        requirements = "@rules_sphinx//sphinx/tools:requirements.txt",
    )
