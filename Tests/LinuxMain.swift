import XCTest

import ESMigrationTests

var tests = [XCTestCaseEntry]()
tests += ESMigrationTests.allTests()
XCTMain(tests)
