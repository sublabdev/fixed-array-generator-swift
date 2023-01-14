import Foundation

struct FixedArrayGenerator {
    let size: Int
    
    func make() -> String {
"""
import Foundation

// MARK: - Array\(size) + Encodable

@propertyWrapper public struct Array\(size)<Element> {
    public var wrappedValue: [Element]
    public init(wrappedValue: [Element]) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Array\(size) + Encodable

extension Array\(size): Encodable where Element : Encodable {
    public func encode(to encoder: Encoder) throws {
        guard wrappedValue.count == \(size) else { throw FixedArrayError.invalidSize }
        var container = encoder.unkeyedContainer()
        try wrappedValue.forEach { try container.encode($0) }
    }
}

// MARK: - Array\(size) + Decodable

extension Array\(size): Decodable where Element : Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        wrappedValue = try (0..<\(size)).map { _ in try container.decode(Element.self) }
    }
}
"""
    }
}
