import Foundation

public struct AppStoreVersionUpdateRequest: Codable, RequestBody {
    public let data: Data

    public init(data: Data) {
        self.data = data
    }

    public struct Data: Codable {
        public let id: String
        public var type: String { "appStoreVersions" }
        public let attributes: Attributes?
        public let relationships: Relationships?

        public init(id: String, attributes: Attributes? = nil, relationships: Relationships? = nil) {
            self.id = id
            self.attributes = attributes
            self.relationships = relationships
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
            relationships = try container.decodeIfPresent(Relationships.self, forKey: .relationships)
            if try container.decode(String.self, forKey: .type) != type {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encodeIfPresent(attributes, forKey: .attributes)
            try container.encodeIfPresent(relationships, forKey: .relationships)
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case attributes
            case relationships
        }

        public struct Attributes: Codable {
            public let copyright: String?
            public let downloadable: Bool?
            public let earliestReleaseDate: Date?
            public let releaseType: ReleaseType?
            public let usesIdfa: Bool?
            public let versionString: String?

            public init(copyright: String? = nil, downloadable: Bool? = nil, earliestReleaseDate: Date? = nil, releaseType: ReleaseType? = nil, usesIdfa: Bool? = nil, versionString: String? = nil) {
                self.copyright = copyright
                self.downloadable = downloadable
                self.earliestReleaseDate = earliestReleaseDate
                self.releaseType = releaseType
                self.usesIdfa = usesIdfa
                self.versionString = versionString
            }

            public enum ReleaseType: String, Codable, CaseIterable {
                case manual = "MANUAL"
                case afterApproval = "AFTER_APPROVAL"
                case scheduled = "SCHEDULED"
            }
        }

        public struct Relationships: Codable {
            public let build: Build?

            public init(build: Build? = nil) {
                self.build = build
            }

            public struct Build: Codable {
                public let data: Data?

                public init(data: Data? = nil) {
                    self.data = data
                }

                public struct Data: Codable {
                    public let id: String
                    public var type: String { "builds" }

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
        }
    }
}
