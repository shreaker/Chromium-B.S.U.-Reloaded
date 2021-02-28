project(shared LANGUAGES CXX)

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}/Version.hpp.in"
    "${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME}/Version.hpp"
)

add_library(${PROJECT_NAME} INTERFACE)

target_include_directories(${PROJECT_NAME}
    INTERFACE
        "${CMAKE_CURRENT_BINARY_DIR}/include"
        "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

file(GLOB_RECURSE HEADER_FILES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")

target_sources(${PROJECT_NAME}
    INTERFACE
        ${HEADER_FILES}
)
