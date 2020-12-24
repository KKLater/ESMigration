import XCTest
@testable import ESMigration

final class ESMigrationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let v1_2_2 = "1.2-test"
        let v1_2_3 = "1.2.3"
        compare(v1: v1_2_2, v2: v1_2_3)
        
        
        let v2_2_3 = "2.2.3"
        let v2_1_3 = "2.1.3"
        compare(v1: v2_2_3, v2: v2_1_3)

        
        let v3_2_2 = "3.2.2"
        let v32_2_2 = "32.2.2"
        compare(v1: v3_2_2, v2: v32_2_2)

        let v4_2_2 = "4.2.2"
        let v4_2_20 = "4.2.20"
        compare(v1: v4_2_2, v2: v4_2_20)

        let v5_2_20 = "5.2.20"
        let v5_22_0 = "5.22.0"
        compare(v1: v5_2_20, v2: v5_22_0)
        
        compare(v1: v1_2_2, v2: v2_2_3)
        compare(v1: v1_2_3, v2: v2_1_3)
        compare(v1: v3_2_2, v2: v4_2_2)
        compare(v1: v32_2_2, v2: v4_2_20)
        compare(v1: v5_2_20, v2: v4_2_20)
        compare(v1: v5_22_0, v2: v4_2_20)
        compare(v1: v4_2_20, v2: v3_2_2)
        
        
        let v1 = "version10.1.0"
        let v2 = "V2.2.0"
        
        
        let flags = v1.compare(v2, options: .numeric) == .orderedDescending
        print("\(v1).compare(\(v2), options: .numeric) == \(flags)")
        
        compare(v1: v1, v2: v2)

        let v11 = "v10.1.0"
        let v22 = "V2.2.0"
        let v23 = "v2.2.0"

        compare(v1: v11, v2: v22)
        compare(v1: v11, v2: v23)

    }

    func compare(v1: String, v2: String) {
        print("\(v1) < \(v2) == \(v1 < v2)")
        print("\(v1) > \(v2) == \(v1 > v2)")
        print("\(v1) <= \(v2) == \(v1 <= v2)")
        print("\(v1) >= \(v2) == \(v1 >= v2)")
    }
    
    
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
