#include <catch2/trompeloeil.hpp>

class MockDemo {
public:
    MAKE_MOCK0(test, void());
};
