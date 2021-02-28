#include "engine/Engine.hpp"

#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>

#include <shared/Version.hpp>

namespace engine {

class Engine::Implementation {
public:
    static Engine::EngineVersion getVersion();

    void sfmlDemoFunction();
};

Engine::Engine() : mImplementation(std::make_unique<Implementation>()) {
}

Engine::~Engine() = default;

Engine::Engine(const Engine& other) : mImplementation(nullptr) {
    if (other.mImplementation) {
        mImplementation = std::make_unique<Implementation>(*other.mImplementation);
    }
}

Engine& Engine::operator=(const Engine& other) {
    if (!other.mImplementation) {
        mImplementation.reset();
    } else if (!mImplementation) {
        // mImplementation could have been moved
        mImplementation = std::make_unique<Implementation>(*other.mImplementation);
    } else {
        *mImplementation = *other.mImplementation;
    }
    return *this;
}

Engine& Engine::operator=(Engine&& other) noexcept = default;

Engine::Engine(Engine&& other) noexcept = default;

Engine::EngineVersion Engine::getVersion() {
    return Implementation::getVersion();
}

void Engine::sfmlDemoFunction() {
    mImplementation->sfmlDemoFunction();
}

Engine::EngineVersion Engine::Implementation::getVersion() {
    return {version::cEngineVersionMajor,
            version::cEngineVersionMinor,
            version::cEngineVersionPatch};
}

void Engine::Implementation::
    sfmlDemoFunction() {  // NOLINT(readability-convert-member-functions-to-static)
    constexpr unsigned int windowSize{400};
    sf::RenderWindow window{sf::VideoMode{windowSize, windowSize}, "SFML works!"};
    sf::CircleShape shape{windowSize / 2.0F};  // NOLINT(readability-magic-numbers)
    shape.setFillColor(sf::Color::Green);

    while (window.isOpen()) {
        sf::Event event{};
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
            }
        }

        window.clear();
        window.draw(shape);
        window.display();
    }
}

}  // namespace engine
