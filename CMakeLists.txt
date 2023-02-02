cmake_minimum_required(VERSION 3.16)

project(GameEngine)
add_subdirectory(Libraries/Engine)
add_subdirectory(Libraries/Test)
include(./cmake/dae/dae_utils.cmake)
DefineLibraries()
include(projects.cmake)
include(InstallRequiredSystemLibraries)
