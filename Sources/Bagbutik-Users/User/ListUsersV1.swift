import Bagbutik_Core
import Bagbutik_Models

public extension Request {
    /**
     # List Users
     Get a list of the users on your team.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/list_users>

     - Parameter fields: Fields to return for included related types
     - Parameter filters: Attributes, relationships, and IDs by which to filter
     - Parameter includes: Relationship data to include in the response
     - Parameter sorts: Attributes by which to sort
     - Parameter limits: Number of resources to return
     - Returns: A ``Request`` to send to an instance of ``BagbutikService``
     */
    static func listUsersV1(fields: [ListUsersV1.Field]? = nil,
                            filters: [ListUsersV1.Filter]? = nil,
                            includes: [ListUsersV1.Include]? = nil,
                            sorts: [ListUsersV1.Sort]? = nil,
                            limits: [ListUsersV1.Limit]? = nil) -> Request<UsersResponse, ErrorResponse>
    {
        .init(path: "/v1/users", method: .get, parameters: .init(fields: fields,
                                                                 filters: filters,
                                                                 includes: includes,
                                                                 sorts: sorts,
                                                                 limits: limits))
    }
}

public enum ListUsersV1 {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type apps
        case apps([Apps])
        /// The fields to include for returned resources of type users
        case users([Users])

        public enum Apps: String, ParameterValue, Codable, CaseIterable {
            case appAvailability
            case appClips
            case appCustomProductPages
            case appEvents
            case appInfos
            case appPricePoints
            case appPriceSchedule
            case appStoreVersions
            case availableInNewTerritories
            case availableTerritories
            case betaAppLocalizations
            case betaAppReviewDetail
            case betaGroups
            case betaLicenseAgreement
            case betaTesters
            case builds
            case bundleId
            case ciProduct
            case contentRightsDeclaration
            case customerReviews
            case endUserLicenseAgreement
            case gameCenterEnabledVersions
            case inAppPurchases
            case inAppPurchasesV2
            case isOrEverWasMadeForKids
            case name
            case perfPowerMetrics
            case preOrder
            case preReleaseVersions
            case pricePoints
            case prices
            case primaryLocale
            case promotedPurchases
            case reviewSubmissions
            case sku
            case subscriptionGracePeriod
            case subscriptionGroups
            case subscriptionStatusUrl
            case subscriptionStatusUrlForSandbox
            case subscriptionStatusUrlVersion
            case subscriptionStatusUrlVersionForSandbox
        }

        public enum Users: String, ParameterValue, Codable, CaseIterable {
            case allAppsVisible
            case firstName
            case lastName
            case provisioningAllowed
            case roles
            case username
            case visibleApps
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by attribute 'roles'
        case roles([UserRole])
        /// Filter by attribute 'username'
        case username([String])
        /// Filter by id(s) of related 'visibleApps'
        case visibleApps([String])
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter, CaseIterable {
        case visibleApps
    }

    /**
     Attributes by which to sort.
     */
    public enum Sort: String, SortParameter, CaseIterable {
        case lastNameAscending = "lastName"
        case lastNameDescending = "-lastName"
        case usernameAscending = "username"
        case usernameDescending = "-username"
    }

    /**
     Number of included related resources to return.
     */
    public enum Limit: LimitParameter {
        /// Maximum resources per page - maximum 200
        case limit(Int)
        /// Maximum number of related visibleApps returned (when they are included) - maximum 50
        case visibleApps(Int)
    }
}
