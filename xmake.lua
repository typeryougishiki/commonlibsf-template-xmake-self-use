-- set minimum xmake version
set_xmakever("2.8.2")

-- add custom package repository
add_repositories("re https://github.com/Starfield-Reverse-Engineering/commonlibsf-xrepo")
-- import changed commonlibsf plugin rule , this rule don't create plugin.cpp
includes("commonlibsf_plugin_without_plugin_cpp.lua")

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

-- require package dependencies
add_requires("commonlibsf")
add_requires("simpleini")

-- setup targets
target(project_name)
    -- bind package dependencies
    add_packages("commonlibsf")
    add_packages("simpleini")
    -- add commonlibsf plugin
    add_rules("commonlibsf_plugin_without_plugin_cpp", {
        name = project_name,
        author = "Author Name",
        description = "Plugin Description"
        email = "user@site.com"
    })
    -- add source files
    set_pcxxheader("src/pch.h")
    add_headerfiles("src/pch/*.h")
    local add_dir_as_source_and_include = function(path)
        add_files(path.."/*.cpp")
        add_headerfiles(path.."/*.h")
        add_includedirs(path)
    end
    add_dir_as_source_and_include("src")
    add_dir_as_source_and_include("src/utils")

    on_install(function (target)
        import("target.action.install.windows")
        windows.install_binary(target, {bindir = "sfse/plugins"})
    end)
