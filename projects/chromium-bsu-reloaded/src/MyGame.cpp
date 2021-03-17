#include "MyGame.hpp"

#include <iostream>

#include <shared/Version.hpp>

void MyGame::printVersion() {  // NOLINT(readability-convert-member-functions-to-static)
    std::cout << "game version: " << version::cGameVersionMajor << "." << version::cGameVersionMinor
              << "." << version::cGameVersionPatch << std::endl;
}
