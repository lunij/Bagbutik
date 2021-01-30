import Foundation

public struct AppPreview: Codable {
    public let id: String
    public let links: ResourceLinks
    public var type: String { "appPreviews" }
    public let attributes: Attributes?
    public let relationships: Relationships?

    public init(id: String, links: ResourceLinks, attributes: Attributes? = nil, relationships: Relationships? = nil) {
        self.id = id
        self.links = links
        self.attributes = attributes
        self.relationships = relationships
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        links = try container.decode(ResourceLinks.self, forKey: .links)
        attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
        relationships = try container.decodeIfPresent(Relationships.self, forKey: .relationships)
        if try container.decode(String.self, forKey: .type) != type {
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(links, forKey: .links)
        try container.encodeIfPresent(attributes, forKey: .attributes)
        try container.encodeIfPresent(relationships, forKey: .relationships)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case links
        case type
        case attributes
        case relationships
    }

    public struct Attributes: Codable {
        public let assetDeliveryState: AppMediaAssetState?
        public let fileName: String?
        public let fileSize: Int?
        public let mimeType: String?
        public let previewFrameTimeCode: String?
        public let previewImage: ImageAsset?
        public let sourceFileChecksum: String?
        public let uploadOperations: [UploadOperation]?
        public let videoUrl: String?

        public init(assetDeliveryState: AppMediaAssetState? = nil, fileName: String? = nil, fileSize: Int? = nil, mimeType: String? = nil, previewFrameTimeCode: String? = nil, previewImage: ImageAsset? = nil, sourceFileChecksum: String? = nil, uploadOperations: [UploadOperation]? = nil, videoUrl: String? = nil) {
            self.assetDeliveryState = assetDeliveryState
            self.fileName = fileName
            self.fileSize = fileSize
            self.mimeType = mimeType
            self.previewFrameTimeCode = previewFrameTimeCode
            self.previewImage = previewImage
            self.sourceFileChecksum = sourceFileChecksum
            self.uploadOperations = uploadOperations
            self.videoUrl = videoUrl
        }
    }

    public struct Relationships: Codable {
        public let appPreviewSet: AppPreviewSet?

        public init(appPreviewSet: AppPreviewSet? = nil) {
            self.appPreviewSet = appPreviewSet
        }

        public struct AppPreviewSet: Codable {
            public let data: Data?
            public let links: Links?

            public init(data: Data? = nil, links: Links? = nil) {
                self.data = data
                self.links = links
            }

            public struct Data: Codable {
                public let id: String
                public var type: String { "appPreviewSets" }

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

            public struct Links: Codable {
                public let related: String?
                public let `self`: String?

                public init(related: String? = nil, self aSelf: String? = nil) {
                    self.related = related
                    self.`self` = aSelf
                }
            }
        }
    }
}
