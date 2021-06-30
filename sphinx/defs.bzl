load("@bazel_skylib//lib:paths.bzl", "paths")


SphinxInfo = provider(
    doc = "Info pertaining to Sphinx build.",
    fields = ["open_uri"],
)


def _sphinx_html_impl(ctx):
    output_dir = ctx.actions.declare_directory(ctx.label.name + "_html")

    args = ctx.actions.args()
    args.add("-b", "html")
    args.add_all(ctx.attr.args)
    args.add(ctx.file.config.dirname)
    args.add(output_dir.path)

    ctx.actions.run(
        outputs = [output_dir],
        inputs = ctx.files.config + ctx.files.srcs,
        executable = ctx.executable._sphinx_build,
        arguments = [args],
        mnemonic = "SphinxBuild",
        progress_message = "Building Sphinx HTML documentation for {}.".format(ctx.label.name),
    )

    return [
        DefaultInfo(files = depset([output_dir])),
        SphinxInfo(open_uri = paths.join(output_dir.short_path, "index.html")),
    ]


sphinx_html_gen = rule(
    implementation = _sphinx_html_impl,
    doc = "Sphinx HTML documentation.",
    attrs = {
        "config": attr.label(
            doc = "Sphinx project config file.",
            allow_single_file = True,
            mandatory = True,
        ),
        "srcs": attr.label_list(
            doc = "Sphinx source and include files.",
            allow_files = True,
            mandatory = True,
            allow_empty = False,
        ),
        "args": attr.string_list(
            doc = "sphinx-build argument list.",
        ),
        "_sphinx_build": attr.label(
            doc = "sphinx-build wrapper.",
            default = Label("@rules_sphinx//sphinx/tools:sphinx_build_wrapper"),
            executable = True,
            cfg = "exec",
        ),
    },
)


def _sphinx_view_impl(ctx):
    shell_cmd = [
        ctx.attr.open_cmd,
        ctx.attr.generator[SphinxInfo].open_uri,
    ]

    script = ctx.actions.declare_file("{}.sh".format(ctx.label.name))
    ctx.actions.write(script, ' '.join(shell_cmd), is_executable = True)

    runfiles = ctx.runfiles(files = ctx.files.generator)

    return [DefaultInfo(executable = script, runfiles = runfiles)]


sphinx_view = rule(
    implementation = _sphinx_view_impl,
    doc = "View Sphinx documentation.",
    attrs = {
        "generator": attr.label(
            doc = "Sphinx documentation generation target.",
            mandatory = True,
            providers = [SphinxInfo],
        ),
        "open_cmd": attr.string(
            doc = "Shell open command for Sphinx URI.",
            default = "xdg-open",
        ),
    },
    executable = True,
)


def sphinx_html(name, **kwargs):
    view_args = {"generator": ":" + name}
    if "open_cmd" in kwargs:
      view_args["open_cmd"] = kwargs.pop("open_cmd")

    sphinx_html_gen(name = name, **kwargs)
    sphinx_view(name = name + ".view", **view_args)
