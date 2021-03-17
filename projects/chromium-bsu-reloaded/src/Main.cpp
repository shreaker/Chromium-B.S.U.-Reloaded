#include <cstdlib>
#include <iostream>

#include <engine/Engine.hpp>

#include "MyGame.hpp"

using engine::Engine;

int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[]) {
    MyGame myGame;
    myGame.printVersion();

    Engine engine;
    auto engineVersion = Engine::getVersion();
    std::cout << "engine version: " << engineVersion.major << "." << engineVersion.minor << "."
              << engineVersion.patch << std::endl;
    engine.sfmlDemoFunction();
    return EXIT_SUCCESS;
}
