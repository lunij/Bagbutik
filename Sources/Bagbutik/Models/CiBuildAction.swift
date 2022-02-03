import Foundation

/**
 The data structure that represents a Build Actions resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction>
 */
public struct CiBuildAction: Codable {
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    /// Navigational links that include the self-link.
    public let links: ResourceLinks
    /// The resource type.
    public var type: String { "ciBuildActions" }
    /// The resource's attributes.
    public let attributes: Attributes?
    /// Navigational links to related data and included resource types and IDs.
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
        try container.encode(type, forKey: .type)
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

    /**
     The attributes that describe a Build Actions resource.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction/attributes>
     */
    public struct Attributes: Codable {
        /// The type of the build action.
        @NullCodable public var actionType: CiActionType?
        /// The status of the action.
        @NullCodable public var completionStatus: CiCompletionStatus?
        /// A string that indicates the progress of the build action.
        @NullCodable public var executionProgress: CiExecutionProgress?
        /// The date and time when Xcode Cloud finished performing the action.
        public var finishedDate: Date?
        /// A Boolean value that indicates whether the action must succeed in order for a build to succeed.
        public var isRequiredToPass: Bool?
        /// An integer value that represents the number of issues Xcode Cloud encountered when it performed the action.
        @NullCodable public var issueCounts: CiIssueCounts?
        /// The name of the build action; for example, Archive iOS.
        public var name: String?
        /// The date and time when Xcode Cloud started performing the action.
        public var startedDate: Date?

        public init(actionType: CiActionType? = nil, completionStatus: CiCompletionStatus? = nil, executionProgress: CiExecutionProgress? = nil, finishedDate: Date? = nil, isRequiredToPass: Bool? = nil, issueCounts: CiIssueCounts? = nil, name: String? = nil, startedDate: Date? = nil) {
            self.actionType = actionType
            self.completionStatus = completionStatus
            self.executionProgress = executionProgress
            self.finishedDate = finishedDate
            self.isRequiredToPass = isRequiredToPass
            self.issueCounts = issueCounts
            self.name = name
            self.startedDate = startedDate
        }
    }

    /**
     The relationships you included in the request and those on which you can operate.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction/relationships>
     */
    public struct Relationships: Codable {
        @NullCodable public var buildRun: BuildRun?

        public init(buildRun: BuildRun? = nil) {
            self.buildRun = buildRun
        }

        /**
         The data and links that describe the relationship between the resources.

         Full documentation:
         <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction/relationships/buildrun>
         */
        public struct BuildRun: Codable {
            /// The type and ID of a related resource.
            @NullCodable public var data: Data?
            /// The links to the related data and the relationship's self-link.
            @NullCodable public var links: Links?

            public init(data: Data? = nil, links: Links? = nil) {
                self.data = data
                self.links = links
            }

            /**
             The type and ID of a related resource.

             Full documentation:
             <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction/relationships/buildrun/data>
             */
            public struct Data: Codable {
                /// The opaque resource ID that uniquely identifies the resource.
                public let id: String
                /// The resource type.
                public var type: String { "ciBuildRuns" }

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
                    try container.encode(type, forKey: .type)
                }

                private enum CodingKeys: String, CodingKey {
                    case id
                    case type
                }
            }

            /**
             The links to the related data and the relationship's self-link.

             Full documentation:
             <https://developer.apple.com/documentation/appstoreconnectapi/cibuildaction/relationships/buildrun/links>
             */
            public struct Links: Codable {
                /// The link to the related data.
                public var related: String?
                /// The relationship's self-link
                public var `self`: String?

                public init(related: String? = nil, self aSelf: String? = nil) {
                    self.related = related
                    self.`self` = aSelf
                }
            }
        }
    }
}