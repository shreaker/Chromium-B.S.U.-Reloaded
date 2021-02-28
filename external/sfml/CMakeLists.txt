# backup variables
fetch_external_project("sfml"
    GIT_REPOSITORY "https://github.com/SFML/SFML.git"
    GIT_TAG "2.5.1"
    RESTORE_CACHE_VARIABLES
        CMAKE_BUILD_TYPE
        BUILD_SHARED_LIBS
)

install(
    TARGETS
        sfml-audio
        sfml-graphics
        sfml-system
        sfml-window
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
)
