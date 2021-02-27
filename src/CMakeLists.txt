# from here: https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if(NOT "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}" IN_LIST CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(extern)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    if(CLANG_TIDY_EXE)
        set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}" "-p=${CMAKE_BINARY_DIR}" -format-style=file)
    endif()
    if(IWYU_EXE)
        set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IWYU_EXE}"
            -Xiwyu "--mapping_file=${CMAKE_SOURCE_DIR}/iwyu-mapping.imp.json"
        )
    endif()
    if(MEMORYCHECK_COMMAND)
        set(MEMORYCHECK_TYPE Valgrind)
        set(MEMORYCHECK_COMMAND_OPTIONS "-q --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=50 --error-exitcode=1 --suppressions=${CMAKE_SOURCE_DIR}/valgrind.supp")
        include(CTest)
    endif()

    # gnu compiler flags
    set(GNU_FLAGS -Werror -Wall -Wextra -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wstrict-overflow=2 -Wwrite-strings -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -Wdeprecated)
    add_compile_options("$<$<CXX_COMPILER_ID:GNU>:${GNU_FLAGS}>")
endif()

add_subdirectory(shared)
add_subdirectory(libengine)
add_subdirectory(chromium-bsu-reloaded)
