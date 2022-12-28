set_xmakever("2.7.3")

set_project("VulkanTutorial")
set_version("0.0.0")

set_allowedplats("windows", "linux", "macosx")
set_allowedarchs("windows|x64", "linux|x64", "macosx|x86_64")

add_rules("mode.debug", "mode.release")
set_languages("cxx20")
set_optimize("fastest")

add_requires("vulkan-hpp v1.3.231")
add_requires("vulkansdk")
add_requires("glfw 3.3.8")
add_requires("glm 0.9.9+8")

local outputdir = "$(mode)-$(os)-$(arch)"

rule("cp-resources")
    after_build(function (target)
        os.cp(target:name() .. "/resources", "build/" .. outputdir .. "/" .. target:name() .. "/bin")
    end)

target("VulkanTutorial")
    set_kind("binary")
    add_rules("cp-resources")

    set_targetdir("build/" .. outputdir .. "/VulkanTutorial/bin")
    set_objectdir("build/" .. outputdir .. "/VulkanTutorial/obj")

    add_packages("vulkan-hpp")
    add_packages("vulkansdk")
    add_packages("glfw")
    add_packages("glm")

    add_files("VulkanTutorial/src/**.cpp")
    add_headerfiles("VulkanTutorial/include/**.hpp", "VulkanTutorial/include/**.h")
    add_includedirs("VulkanTutorial/include/", {public = true})