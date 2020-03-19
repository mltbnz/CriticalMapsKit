//
//  Location.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 12/17/18.
//

import Foundation

public struct Location: Equatable, Hashable {
    public var longitude: Double
    public var latitude: Double
    public var timestamp: Float
    public var name: String?
    public var color: String?
}

extension Location: Codable {
    private enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case timestamp
        case name
        case color
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try latitude = container.decode(Double.self, forKey: .latitude) / 1_000_000
        try longitude = container.decode(Double.self, forKey: .longitude) / 1_000_000
        try timestamp = container.decode(Float.self, forKey: .timestamp)
        try name = container.decodeIfPresent(String.self, forKey: .name)
        try color = container.decodeIfPresent(String.self, forKey: .color)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(longitude * 1_000_000, forKey: .longitude)
        try container.encode(latitude * 1_000_000, forKey: .latitude)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encodeIfPresent(color, forKey: .color)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
