import Foundation

public extension Collection {

    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> [Result] {
        var results = [Result]()
        var currentResult = initialResult
        for element in self {
            currentResult = try nextPartialResult(currentResult, element)
            results.append(currentResult)
        }
        return results
    }

    func count(where condition: (Element) throws -> Bool ) rethrows -> Int {
        try reduce(0) { (partialCount, value) in
            return try partialCount + (condition(value) ? 1 : 0)
        }
    }

    func sum<T: Numeric>(for keyPath: KeyPath<Element, T>) -> T {
        return reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
}
