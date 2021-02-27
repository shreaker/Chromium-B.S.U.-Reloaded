project(catch2 LANGUAGES NONE)

configure_file(CMakeLists.txt.in catch2-download/CMakeLists.txt)

execute_process(
    COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/catch2-download"
)

execute_process(
    COMMAND "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/catch2-download"
)

# Add catch2 directly to our build.
add_subdirectory(
    "${EXTERNAL_INSTALL_LOCATION}/catch2-src"
    "${EXTERNAL_INSTALL_LOCATION}/catch2-build"
    EXCLUDE_FROM_ALL
)

list(APPEND CMAKE_MODULE_PATH "${EXTERNAL_INSTALL_LOCATION}/catch2-src/contrib")
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
