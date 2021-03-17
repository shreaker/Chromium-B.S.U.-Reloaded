project(engine LANGUAGES CXX)

include(GenerateExportHeader) # needed for generate_export_header()

# gather source files
file(GLOB_RECURSE PUBLIC_HEADER_FILES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}/*.hpp")
file(GLOB_RECURSE SOURCE_FILES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.[c|h]pp")

add_library(${PROJECT_NAME} SHARED ${PUBLIC_HEADER_FILES} ${SOURCE_FILES})

# from here: https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set_target_properties(${PROJECT_NAME}
    PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS TRUE
)

generate_export_header(${PROJECT_NAME})

target_link_system_libraries(${PROJECT_NAME}
    PRIVATE
        sfml-audio
        sfml-graphics
        sfml-system
        sfml-window
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        shared
)

# Define headers for this library. PUBLIC headers are used for compiling the library, and will be added to consumers' build paths.
target_include_directories(${PROJECT_NAME}
    PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
        "$<INSTALL_INTERFACE:include>"
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Config
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
)

# This makes the project importable from the build directory
export(TARGETS ${PROJECT_NAME}
    FILE ${PROJECT_NAME}Config.cmake
)

add_subdirectory(tests)
