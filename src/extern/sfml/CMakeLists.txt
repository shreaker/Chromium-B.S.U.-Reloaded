project(sfml LANGUAGES NONE)

configure_file(CMakeLists.txt.in sfml-download/CMakeLists.txt)

execute_process(
    COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/sfml-download"
)

execute_process(
    COMMAND "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/sfml-download"
)

set(CMAKE_CXX_STANDARD 14) # sfml uses std::auto_ptr. this fixes MSVC build

# we need to backup some variables because they are altered by sfml
set(_CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE})
set(_BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS})

add_subdirectory(
    "${EXTERNAL_INSTALL_LOCATION}/sfml-src"
    "${EXTERNAL_INSTALL_LOCATION}/sfml-build"
    EXCLUDE_FROM_ALL
)

if(NOT _CMAKE_BUILD_TYPE)
    unset(CMAKE_BUILD_TYPE CACHE)
else()
    set(CMAKE_BUILD_TYPE ${_CMAKE_BUILD_TYPE} CACHE STRING "")
endif()

if(NOT _BUILD_SHARED_LIBS)
    unset(BUILD_SHARED_LIBS CACHE)
else()
    set(BUILD_SHARED_LIBS ${_BUILD_SHARED_LIBS} CACHE BOOL "")
endif()

install(
    TARGETS
        sfml-audio
        sfml-graphics
        sfml-system
        sfml-window
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
)
