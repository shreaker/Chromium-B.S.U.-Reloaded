#define CATCH_CONFIG_MAIN

#include <catch2/catch.hpp>

#include "MockDemo.hpp"

TEST_CASE("main test case", "dummy") {
    MockDemo mock;

    REQUIRE_CALL(mock, test()).TIMES(1);
    mock.test();
}
