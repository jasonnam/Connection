import XCTest

import ConnectionTests

var tests = [XCTestCaseEntry]()
tests += ConnectionTests.allTests()
XCTMain(tests)
