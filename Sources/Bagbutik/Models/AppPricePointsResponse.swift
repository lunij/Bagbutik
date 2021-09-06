import Foundation

/**
 A response that contains a list of App Price Point resources.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/apppricepointsresponse>
 */
public struct AppPricePointsResponse: Codable, PagedResponse {
    public typealias Data = AppPricePoint
    /// The resource data.
    public let data: [AppPricePoint]
    /// The included related resources.
    public let included: [Included]?
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    /// Paging information.
    public let meta: PagingInformation?

    public init(data: [AppPricePoint], included: [Included]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }

    public enum Included: Codable {
        case priceTier(AppPriceTier)
        case territory(Territory)

        public init(from decoder: Decoder) throws {
            if let priceTier = try? AppPriceTier(from: decoder) {
                self = .priceTier(priceTier)
            } else if let territory = try? Territory(from: decoder) {
                self = .territory(territory)
            } else {
                throw DecodingError.typeMismatch(Included.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                      debugDescription: "Unknown Included"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case let .priceTier(value):
                try value.encode(to: encoder)
            case let .territory(value):
                try value.encode(to: encoder)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type
        }

        private enum TypeKeys: String, Codable {
            case priceTier
            case territory
        }
    }
}
