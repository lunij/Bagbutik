import Foundation

public struct BetaTesterBetaGroupsLinkagesResponse: Codable {
    public let data: [Data]
    public let links: PagedDocumentLinks
    public let meta: PagingInformation?

    public init(data: [Data], links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.links = links
        self.meta = meta
    }

    public struct Data: Codable {
        public let id: String
        public var type: String { "betaGroups" }

        public init(id: String) {
            self.id = id
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            if try container.decode(String.self, forKey: .type) != type {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case type
        }
    }
}
