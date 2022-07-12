public extension Request {
    /**
      # No overview available

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter includes: Relationship data to include in the response
      - Parameter sorts: Attributes by which to sort
      - Parameter limits: Number of resources to return
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listSubscriptionGroupsForAppV1(id: String,
                                               fields: [ListSubscriptionGroupsForAppV1.Field]? = nil,
                                               filters: [ListSubscriptionGroupsForAppV1.Filter]? = nil,
                                               includes: [ListSubscriptionGroupsForAppV1.Include]? = nil,
                                               sorts: [ListSubscriptionGroupsForAppV1.Sort]? = nil,
                                               limits: [ListSubscriptionGroupsForAppV1.Limit]? = nil) -> Request<SubscriptionGroupsResponse, ErrorResponse>
    {
        return .init(path: "/v1/apps/\(id)/subscriptionGroups", method: .get, parameters: .init(fields: fields,
                                                                                                filters: filters,
                                                                                                includes: includes,
                                                                                                sorts: sorts,
                                                                                                limits: limits))
    }
}

public enum ListSubscriptionGroupsForAppV1 {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type subscriptionGroupLocalizations
        case subscriptionGroupLocalizations([SubscriptionGroupLocalizations])
        /// The fields to include for returned resources of type subscriptionGroups
        case subscriptionGroups([SubscriptionGroups])
        /// The fields to include for returned resources of type subscriptions
        case subscriptions([Subscriptions])

        public enum SubscriptionGroupLocalizations: String, ParameterValue, CaseIterable {
            case customAppName
            case locale
            case name
            case state
            case subscriptionGroup
        }

        public enum SubscriptionGroups: String, ParameterValue, CaseIterable {
            case app
            case referenceName
            case subscriptionGroupLocalizations
            case subscriptions
        }

        public enum Subscriptions: String, ParameterValue, CaseIterable {
            case appStoreReviewScreenshot
            case availableInAllTerritories
            case familySharable
            case group
            case groupLevel
            case introductoryOffers
            case name
            case offerCodes
            case pricePoints
            case prices
            case productId
            case promotedPurchase
            case promotionalOffers
            case reviewNote
            case state
            case subscriptionLocalizations
            case subscriptionPeriod
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by attribute 'referenceName'
        case referenceName([String])
        /// Filter by attribute 'subscriptions.state'
        case subscriptions_state([SubscriptionsState])

        public enum SubscriptionsState: String, ParameterValue, CaseIterable {
            case missingMetadata = "MISSING_METADATA"
            case readyToSubmit = "READY_TO_SUBMIT"
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case developerActionNeeded = "DEVELOPER_ACTION_NEEDED"
            case pendingBinaryApproval = "PENDING_BINARY_APPROVAL"
            case approved = "APPROVED"
            case developerRemovedFromSale = "DEVELOPER_REMOVED_FROM_SALE"
            case removedFromSale = "REMOVED_FROM_SALE"
            case rejected = "REJECTED"
        }
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case subscriptionGroupLocalizations, subscriptions
    }

    /**
     Attributes by which to sort.
     */
    public enum Sort: String, SortParameter {
        case referenceNameAscending = "referenceName"
        case referenceNameDescending = "-referenceName"
    }

    /**
     Number of included related resources to return.
     */
    public enum Limit: LimitParameter {
        /// Maximum resources per page - maximum 200
        case limit(Int)
        /// Maximum number of related subscriptions returned (when they are included) - maximum 50
        case subscriptions(Int)
        /// Maximum number of related subscriptionGroupLocalizations returned (when they are included) - maximum 50
        case subscriptionGroupLocalizations(Int)
    }
}
