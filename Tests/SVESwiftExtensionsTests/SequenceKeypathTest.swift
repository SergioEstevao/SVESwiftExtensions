import XCTest
@testable import SVESwiftExtensions

class SequenceKeypathTest: XCTestCase {

    struct Person: Equatable {
        let name: String
        let age: Int
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeypathMap() {

        let data = [Person(name: "Sergio", age: 42),
                    Person(name: "Ines", age: 41),
                    Person(name: "Sara", age: 10),
                    Person(name: "Sofia", age: 6),
                    Person(name: "Lea", age: 1)];

        let result = data.map(\.name)

        XCTAssertTrue(result.elementsEqual(["Sergio", "Ines", "Sara", "Sofia", "Lea"]))
    }

    func testKeypathSorted() {
        let data = [Person(name: "Sergio", age: 42),
        Person(name: "Ines", age: 41),
        Person(name: "Sara", age: 10),
        Person(name: "Sofia", age: 6),
        Person(name: "Lea", age: 1)];

        let result = data.sorted(by: \.age)

        XCTAssertEqual(result, data.reversed())
    }

    static var allTests = [
        ("testKeypathMap", testKeypathMap),
        ("testKeypathSorted", testKeypathSorted)
    ]

}
