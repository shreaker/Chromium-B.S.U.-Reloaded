#disable all warnings for 3rdparty libs
add_compile_options(
    "$<$<CXX_COMPILER_ID:GNU>:-w>"
    "$<$<CXX_COMPILER_ID:MSVC>:/w>"
)

#add_subdirectory(googletest)
add_subdirectory(catch2)
add_subdirectory(trompeloeil)
add_subdirectory(sfml)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)

# catch2 treatment
include(Catch)
set(_CATCH_DISCOVER_TESTS_SCRIPT "${_CATCH_DISCOVER_TESTS_SCRIPT}" PARENT_SCOPE)
