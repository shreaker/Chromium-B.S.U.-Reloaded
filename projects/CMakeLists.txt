# from here: https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if(NOT "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}" IN_LIST CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(RUN_CLANG_TIDY AND CLANG_TIDY_EXE)
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}" "-p=${CMAKE_BINARY_DIR}" -format-style=file)
endif()
if(RUN_IWYU AND IWYU_EXE)
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IWYU_EXE}"
        -Xiwyu "--mapping_file=${CMAKE_SOURCE_DIR}/iwyu-mapping.imp.json"
    )
endif()
if(RUN_MEMORYCHECK AND MEMORYCHECK_COMMAND)
    set(MEMORYCHECK_TYPE Valgrind)
    set(MEMORYCHECK_COMMAND_OPTIONS "-q --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=50 --error-exitcode=1 --suppressions=${CMAKE_SOURCE_DIR}/valgrind.supp")
    include(CTest)
endif()

add_cxx_compiler_flags(
    -pedantic-errors
    -Wall
    -Wcast-align
    -Wcast-qual
    -Wconversion
    -Wdelete-non-virtual-dtor
    -Wdeprecated
    -Werror
    -Wextra
    -Wfloat-equal
    -Wformat-signedness
    -Wformat=2
    -Wlogical-op
    -Wnon-virtual-dtor
    -Wnull-dereference
    -Wold-style-cast
    -Woverloaded-virtual
    -Wpedantic
    -Wshadow
    -Wstrict-overflow=2
    -Wswitch-enum
    -Wundef
    -Wuseless-cast
    -Wwrite-strings
)

add_subdirectory(shared)
add_subdirectory(libengine)
add_subdirectory(chromium-bsu-reloaded)
