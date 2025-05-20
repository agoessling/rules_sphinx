workspace(name = "rules_sphinx")

# ----- Direct deps ----- #

load("@rules_sphinx//sphinx:direct_repositories.bzl", "rules_sphinx_direct_deps")

rules_sphinx_direct_deps()

# ----- rules_python ----- #

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

load("@rules_python//python:repositories.bzl", "python_register_toolchains")

python_register_toolchains(
    name = "python_3_11",
    python_version = "3.11",
)

# ----- rules_sphinx deps ----- #

load("@rules_python//python:pip.bzl", "pip_parse")

pip_parse(
    name = "sphinx_deps",
    requirements_lock = "@rules_sphinx//sphinx/tools:requirements.txt",
)

load("@sphinx_deps//:requirements.bzl", "install_deps")

install_deps()
