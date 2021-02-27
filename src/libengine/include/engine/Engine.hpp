#pragma once

#include <cstdint>
#include <memory>

namespace engine {

class Engine {
public:
    struct EngineVersion {
    public:
        const uint16_t major;
        const uint16_t minor;
        const uint16_t patch;
    };

public:
    explicit Engine();

    virtual ~Engine();

    Engine(const Engine& other);

    Engine& operator=(const Engine& other);

    Engine(Engine&& other) noexcept;

    Engine& operator=(Engine&& other) noexcept;

    static EngineVersion getVersion();

    void sfmlDemoFunction();

private:
    class Implementation;
    std::unique_ptr<Implementation> mImplementation;
};

}  // namespace engine
