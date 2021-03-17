unset(CMAKE_CXX_CLANG_TIDY)

set(UNIT_TEST_EXE_NAME ut_${PROJECT_NAME})

file(GLOB_RECURSE TEST_SOURCE_FILES CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/*.[c|h]pp")

add_executable(${UNIT_TEST_EXE_NAME} ${TEST_SOURCE_FILES})

if(MINGW)
    target_compile_options(${UNIT_TEST_EXE_NAME} PRIVATE "-Wa,-mbig-obj")
endif()

target_link_system_libraries(${UNIT_TEST_EXE_NAME}
    PRIVATE
        Catch2::Catch2
        trompeloeil
)

catch_discover_tests(${UNIT_TEST_EXE_NAME})
