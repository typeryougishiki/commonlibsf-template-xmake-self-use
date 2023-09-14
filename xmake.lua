-- set minimum xmake version
set_xmakever("2.8.2")

-- add starfield-re-xrepo repository
add_repositories("re https://github.com/Starfield-Reverse-Engineering/commonlibsf-xrepo")

-- set project
set_project("template-commonlibsf")
set_version("0.0.0")
set_license("GPL-3.0")

-- set defaults
set_languages("c++23")
set_optimize("faster")
set_warnings("allextra", "error")

-- add rules
add_rules("plugin.vsxmake.autoupdate")

-- require packages
add_requires("commonlibsf")

target("commonlibsf-template")
    -- add packages
    add_packages("commonlibsf", "fmt", "spdlog")

    -- add commonlibsf plugin
    add_rules("@commonlibsf/plugin", {
        name = "commonlibsf-template",
        author = "Author Name",
        description = "Plugin Description",
        email = "user@site.com"
    })

    -- add source files
    add_files("src/*.cpp")
    add_headerfiles("src/*.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")
