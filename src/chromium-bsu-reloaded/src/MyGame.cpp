#include "MyGame.hpp"

#include <iostream>

#include <shared/Version.hpp>

void MyGame::printVersion() {
    std::cout << "game version: " << version::GAME_VERSION_MAJOR << "."
              << version::GAME_VERSION_MINOR << "." << version::GAME_VERSION_PATCH << std::endl;
}
