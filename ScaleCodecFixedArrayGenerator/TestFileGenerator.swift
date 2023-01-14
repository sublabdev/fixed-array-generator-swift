import Foundation

struct TestFileGenerator {
    var fixedArrayGenerators: [FixedArrayGenerator] = []
    
    private func makeTest(size: Int) -> String {
"""
    func testArray\(size)() throws {
        let codec = ScaleCoder.default()
        var array\(size) = Array\(size)(wrappedValue: (0..<\(size)).map { _ in UUID().uuidString })
        let encoded = try codec.encoder.encode(array\(size))
        let decoded = try codec.decoder.decode(Array\(size)<String>.self, from: encoded)
        XCTAssertEqual(array\(size).wrappedValue, decoded.wrappedValue)
        
        func failingEncodingWithExtraElement() throws {
            array\(size).wrappedValue.append(UUID().uuidString)
            _ = try codec.encoder.encode(array\(size))
        }
        XCTAssertThrowsError(try failingEncodingWithExtraElement())
    }
"""
    }
    
    private func makeTests() -> String {
        fixedArrayGenerators
            .map { makeTest(size: $0.size) }
            .joined(separator: "\n\n")
    }
    
    func make() -> String {
"""
@testable import ScaleCodecSwift
import XCTest

final class TestFixedSizedArrays: XCTestCase {
\(makeTests())
}
"""
    }
}
