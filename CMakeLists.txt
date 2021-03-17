cmake_minimum_required(VERSION 3.19 FATAL_ERROR)
project(chromium-bsu-reloaded LANGUAGES NONE)

option(RUN_CLANG_TIDY "Run clang-tidy" ON)
option(RUN_IWYU "Run iwyu" ON)
option(RUN_MEMORYCHECK "Run memorycheck" ON)

set(GAME_VERSION_MAJOR 0)
set(GAME_VERSION_MINOR 1)
set(GAME_VERSION_PATCH 0)

set(ENGINE_VERSION_MAJOR 0)
set(ENGINE_VERSION_MINOR 1)
set(ENGINE_VERSION_PATCH 0)

####################################################################################
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR ${GAME_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${GAME_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${GAME_VERSION_PATCH})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to Debug as none was specified.")
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build." FORCE)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(CPACK_DEBIAN_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
    set(CPACK_DEBIAN_PACKAGE_MAINTAINER "chromium-bsu-reloaded team")
    set(CPACK_GENERATOR "DEB;STGZ;TGZ")
    set(CPACK_PACKAGING_INSTALL_PREFIX "/opt")

    if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
        set(CMAKE_INSTALL_PREFIX "/opt" CACHE PATH "Default install path" FORCE)
    endif()

    set(CMAKE_INSTALL_BINDIR "${CPACK_PACKAGE_NAME}/bin")
    set(CMAKE_INSTALL_LIBDIR "${CPACK_PACKAGE_NAME}/lib")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    find_program(7Z_EXE 7z)
    find_program(NSIS_EXE makensis)

    if(7Z_EXE)
        list(APPEND CPACK_GENERATOR 7Z)
    endif()
    if(NSIS_EXE)
        list(APPEND CPACK_GENERATOR NSIS64)
    endif()

    # windows has no rpath
    set(CMAKE_INSTALL_BINDIR ".")
    set(CMAKE_INSTALL_LIBDIR ".")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CPACK_PACKAGE_NAME}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CPACK_PACKAGE_NAME}")
endif()

find_program(MEMORYCHECK_COMMAND valgrind)
find_program(CLANG_TIDY_EXE clang-tidy)
find_program(IWYU_EXE NAMES include-what-you-use iwyu)
find_package(Git REQUIRED)

include(BuildUtils)
include(ExternalProjectUtils)
include(LinkLibraryUtils)
include(CTest)
include(CPack)

set(EXTERNAL_INSTALL_LOCATION "${CMAKE_BINARY_DIR}/external")
include_directories("${EXTERNAL_INSTALL_LOCATION}/include")
link_directories("${EXTERNAL_INSTALL_LOCATION}/lib")

# generate JSON compilation database
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

add_subdirectory(external)
add_subdirectory(projects)
