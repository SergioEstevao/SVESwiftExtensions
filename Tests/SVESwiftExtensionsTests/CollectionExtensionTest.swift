import XCTest
@testable import SVESwiftExtensions

class CollectionExtensionTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAccumulate() {

        let data = [1, 2, 3, 4, 5];

        let result = data.accumulate(0, +)

        XCTAssertEqual(data.count, result.count)
        XCTAssertTrue(result.elementsEqual([1, 3, 6, 10, 15]))
    }

    func testCount() {
        let data = [1, 2, 3, 4, 5, 6];

        let result = data.count(where: { $0.isMultiple(of:2) } )

        XCTAssertEqual(result, 3)
    }

    func testSome() {
        let data = [1, 2, 3, 4, 5, 6];

        let result = data.some(where: { $0.isMultiple(of:2) } )

        XCTAssertTrue(result)

        XCTAssertFalse(data.some(where: { $0.isMultiple(of:10) } ))
    }
    static var allTests = [
        ("testAccumulate", testAccumulate),
        ("testCount", testCount)
    ]

}
