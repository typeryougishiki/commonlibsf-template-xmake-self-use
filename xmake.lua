-- set minimum xmake version
set_xmakever("2.8.2")

-- add commonlibsf-xrepo repository
add_repositories("re https://github.com/Starfield-Reverse-Engineering/commonlibsf-xrepo")

project_name = "commonlibsf-template"

-- set project
set_project(project_name)
set_version("0.0.0")
set_license("GPL-3.0")

-- set defaults
set_languages("c++23")
set_optimize("faster")
set_warnings("allextra", "error")
set_defaultmode("releasedbg")

-- add rules
add_rules("mode.releasedbg", "mode.debug")
add_rules("plugin.vsxmake.autoupdate")
add_rules("plugin.compile_commands.autoupdate", {lsp = "clangd"})

-- require packages
add_requires("commonlibsf")

target(project_name)
    -- add packages
    add_packages("commonlibsf")

    -- add commonlibsf plugin
    add_rules("@commonlibsf/plugin", {
        name = project_name,
        author = "Author Name",
        description = "Plugin Description"
    })

    -- add source files
    add_files("src/*.cpp")
    add_headerfiles("src/*.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")

    on_install(function (target)
        import("target.action.install.windows")
        windows.install_binary(target, {bindir = "sfse/plugins"})
    end)
