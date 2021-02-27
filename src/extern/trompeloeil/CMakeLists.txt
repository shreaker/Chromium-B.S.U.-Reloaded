project(trompeloeil LANGUAGES NONE)

configure_file(CMakeLists.txt.in trompeloeil-download/CMakeLists.txt)

execute_process(
    COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/trompeloeil-download"
)

execute_process(
    COMMAND "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/trompeloeil-download"
)

# Add trompeloeil directly to our build.
add_subdirectory(
    "${EXTERNAL_INSTALL_LOCATION}/trompeloeil-src"
    "${EXTERNAL_INSTALL_LOCATION}/trompeloeil-build"
    EXCLUDE_FROM_ALL
)
