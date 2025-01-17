import Bagbutik_Core
import Foundation

/**
 # BetaGroupsResponse
 A response that contains a list of Beta Group resources.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/betagroupsresponse>
 */
public struct BetaGroupsResponse: Codable, PagedResponse {
    public typealias Data = BetaGroup

    /// The resource data.
    public let data: [BetaGroup]
    public var included: [Included]?
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    /// Paging information.
    public var meta: PagingInformation?

    public init(data: [BetaGroup],
                included: [Included]? = nil,
                links: PagedDocumentLinks,
                meta: PagingInformation? = nil)
    {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }

    public func getApp(for betaGroup: BetaGroup) -> App? {
        included?.compactMap { relationship -> App? in
            guard case let .app(app) = relationship else { return nil }
            return app
        }.first { $0.id == betaGroup.relationships?.app?.data?.id }
    }

    public func getBetaTesters(for betaGroup: BetaGroup) -> [BetaTester] {
        guard let betaTesterIds = betaGroup.relationships?.betaTesters?.data?.map(\.id),
              let betaTesters = included?.compactMap({ relationship -> BetaTester? in
                  guard case let .betaTester(betaTester) = relationship else { return nil }
                  return betaTesterIds.contains(betaTester.id) ? betaTester : nil
              })
        else {
            return []
        }
        return betaTesters
    }

    public func getBuilds(for betaGroup: BetaGroup) -> [Build] {
        guard let buildIds = betaGroup.relationships?.builds?.data?.map(\.id),
              let builds = included?.compactMap({ relationship -> Build? in
                  guard case let .build(build) = relationship else { return nil }
                  return buildIds.contains(build.id) ? build : nil
              })
        else {
            return []
        }
        return builds
    }

    public enum Included: Codable {
        case app(App)
        case betaTester(BetaTester)
        case build(Build)

        public init(from decoder: Decoder) throws {
            if let app = try? App(from: decoder) {
                self = .app(app)
            } else if let betaTester = try? BetaTester(from: decoder) {
                self = .betaTester(betaTester)
            } else if let build = try? Build(from: decoder) {
                self = .build(build)
            } else {
                throw DecodingError.typeMismatch(Included.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                      debugDescription: "Unknown Included"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case let .app(value):
                try value.encode(to: encoder)
            case let .betaTester(value):
                try value.encode(to: encoder)
            case let .build(value):
                try value.encode(to: encoder)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type
        }
    }
}
