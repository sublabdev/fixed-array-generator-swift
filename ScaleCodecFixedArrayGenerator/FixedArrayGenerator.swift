import Foundation

struct FixedArrayGenerator {
    let size: Int
    
    func make() -> String {
"""
import Foundation

// MARK: - Array\(size) + Encodable

/// An array with \(size) \(size > 1 ? "elements" : "element")
@propertyWrapper public struct Array\(size)<Element> {
    public var wrappedValue: [Element]
    public init(wrappedValue: [Element]) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Array\(size) + Encodable

extension Array\(size): Encodable where Element : Encodable {
    /// Encodes the array via provided encoder
    /// - Parameters:
    ///     - encoder: An encoder that is used to encode the array
    public func encode(to encoder: Encoder) throws {
        guard wrappedValue.count == \(size) else { throw FixedArrayError.invalidSize }
        var container = encoder.unkeyedContainer()
        try wrappedValue.forEach { try container.encode($0) }
    }
}

// MARK: - Array\(size) + Decodable

extension Array\(size): Decodable where Element : Decodable {
    /// Creates a fixed array with with \(size) \(size > 1 ? "elements" : "element") using the provided decoder, by decoding its each element
    /// - Parameters:
    ///     - decoder: Decoder, used to create the array
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        wrappedValue = try (0..<\(size)).map { _ in try container.decode(Element.self) }
    }
}
"""
    }
}
