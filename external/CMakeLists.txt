add_subdirectory(trompeloeil)
add_subdirectory(sfml)
add_subdirectory(catch2)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)

# catch2 treatment
include(Catch)
set(_CATCH_DISCOVER_TESTS_SCRIPT "${_CATCH_DISCOVER_TESTS_SCRIPT}" PARENT_SCOPE)
