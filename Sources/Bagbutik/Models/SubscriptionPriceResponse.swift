import Foundation

public struct SubscriptionPriceResponse: Codable {
    public let data: SubscriptionPrice
    public var included: [Included]?
    public let links: DocumentLinks

    public init(data: SubscriptionPrice, included: [Included]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }

    public func getSubscriptionPricePoint() -> SubscriptionPricePoint? {
        included?.compactMap { relationship -> SubscriptionPricePoint? in
            guard case let .subscriptionPricePoint(subscriptionPricePoint) = relationship else { return nil }
            return subscriptionPricePoint
        }.first { $0.id == data.relationships?.subscriptionPricePoint?.data?.id }
    }

    public func getTerritory() -> Territory? {
        included?.compactMap { relationship -> Territory? in
            guard case let .territory(territory) = relationship else { return nil }
            return territory
        }.first { $0.id == data.relationships?.territory?.data?.id }
    }

    public enum Included: Codable {
        case subscriptionPricePoint(SubscriptionPricePoint)
        case territory(Territory)

        public init(from decoder: Decoder) throws {
            if let subscriptionPricePoint = try? SubscriptionPricePoint(from: decoder) {
                self = .subscriptionPricePoint(subscriptionPricePoint)
            } else if let territory = try? Territory(from: decoder) {
                self = .territory(territory)
            } else {
                throw DecodingError.typeMismatch(Included.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                      debugDescription: "Unknown Included"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case let .subscriptionPricePoint(value):
                try value.encode(to: encoder)
            case let .territory(value):
                try value.encode(to: encoder)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type
        }
    }
}
