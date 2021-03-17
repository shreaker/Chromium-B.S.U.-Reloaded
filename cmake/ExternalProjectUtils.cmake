cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

include(CMakeUtils)
include(FetchContent)

function(fetch_external_project name)
    set(options)
    set(singleValueArgs SUBDIRECTORY_PATH)
    set(multiValueArgs INCLUDE_DIRECTORIES CMAKE_MODULE_PATHS RESTORE_CACHE_VARIABLES)
    cmake_parse_arguments(ARG "${options}" "${singleValueArgs}" "${multiValueArgs}" ${ARGN})

    string(TOLOWER ${name} name)
    string(MAKE_C_IDENTIFIER ${name} name)
    FetchContent_Declare("${name}" ${ARG_UNPARSED_ARGUMENTS})
    FetchContent_GetProperties("${name}")
    if(NOT ${name}_POPULATED)
        message(STATUS "Fetching project: ${name}")
        FetchContent_Populate("${name}")
    else()
        message(STATUS "Using cached project: ${name}")
    endif()

    set(projectSourceDir "${${name}_SOURCE_DIR}")
    set(projectBinaryDir "${${name}_BINARY_DIR}")

    # ignore all warnings and tools for thirdparty libs.
    # we have to use variables here because add_compile_options will propagate to the entire current directory
    if(CMAKE_C_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR
        CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        string(APPEND CMAKE_C_FLAGS " -w")
        string(APPEND CMAKE_CXX_FLAGS " -w")
    elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        string(APPEND CMAKE_C_FLAGS " /w")
        string(APPEND CMAKE_CXX_FLAGS " /w")
    endif()

    unset(CMAKE_C_CLANG_TIDY)
    unset(CMAKE_CXX_CLANG_TIDY)
    unset(CMAKE_C_INCLUDE_WHAT_YOU_USE)
    unset(CMAKE_CXX_INCLUDE_WHAT_YOU_USE)

    if(DEFINED ARG_RESTORE_CACHE_VARIABLES)
        foreach(cacheVariable IN LISTS ARG_RESTORE_CACHE_VARIABLES)
            store_cache_variable(${cacheVariable})
        endforeach()
    endif()
    add_subdirectory(
        "${projectSourceDir}/${ARG_SUBDIRECTORY_PATH}"
        "${projectBinaryDir}"
        EXCLUDE_FROM_ALL
    )
    if(DEFINED ARG_RESTORE_CACHE_VARIABLES)
        foreach(cacheVariable IN LISTS ARG_RESTORE_CACHE_VARIABLES)
            load_cache_variable(${cacheVariable} STRING)
        endforeach()
    endif()
    if(DEFINED ARG_INCLUDE_DIRECTORIES)
        foreach(includeDirectory IN LISTS ARG_INCLUDE_DIRECTORIES)
            include_directories("${projectSourceDir}/${includeDirectory}")
        endforeach()
    endif()
    if(DEFINED ARG_CMAKE_MODULE_PATHS)
        foreach(modulePath IN LISTS ARG_CMAKE_MODULE_PATHS)
            list(APPEND CMAKE_MODULE_PATH "${projectSourceDir}/${modulePath}")
        endforeach()
        set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
    endif()
endfunction()
