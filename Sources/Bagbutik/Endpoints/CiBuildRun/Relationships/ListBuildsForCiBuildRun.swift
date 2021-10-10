public extension Request {
    /**
      # List All Builds Xcode Cloud Created in App Store Connect
      List All App Store Connect and TestFlight Builds when it performed a build.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_xcode_cloud_created_in_app_store_connect>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter includes: Relationship data to include in the response
      - Parameter sorts: Attributes by which to sort
      - Parameter limits: Number of resources to return
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listBuildsForCiBuildRun(id: String,
                                        fields: [ListBuildsForCiBuildRun.Field]? = nil,
                                        filters: [ListBuildsForCiBuildRun.Filter]? = nil,
                                        includes: [ListBuildsForCiBuildRun.Include]? = nil,
                                        sorts: [ListBuildsForCiBuildRun.Sort]? = nil,
                                        limits: [ListBuildsForCiBuildRun.Limit]? = nil) -> Request<BuildsResponse, ErrorResponse>
    {
        return .init(path: "/v1/ciBuildRuns/\(id)/builds", method: .get, parameters: .init(fields: fields,
                                                                                           filters: filters,
                                                                                           includes: includes,
                                                                                           sorts: sorts,
                                                                                           limits: limits))
    }
}

public enum ListBuildsForCiBuildRun {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type betaBuildLocalizations
        case betaBuildLocalizations([BetaBuildLocalizations])
        /// The fields to include for returned resources of type betaTesters
        case betaTesters([BetaTesters])
        /// The fields to include for returned resources of type buildIcons
        case buildIcons([BuildIcons])
        /// The fields to include for returned resources of type builds
        case builds([Builds])

        public enum BetaBuildLocalizations: String, ParameterValue, CaseIterable {
            case build
            case locale
            case whatsNew
        }

        public enum BetaTesters: String, ParameterValue, CaseIterable {
            case apps
            case betaGroups
            case builds
            case email
            case firstName
            case inviteType
            case lastName
        }

        public enum BuildIcons: String, ParameterValue, CaseIterable {
            case iconAsset
            case iconType
        }

        public enum Builds: String, ParameterValue, CaseIterable {
            case app
            case appEncryptionDeclaration
            case appStoreVersion
            case betaAppReviewSubmission
            case betaBuildLocalizations
            case betaGroups
            case buildAudienceType
            case buildBetaDetail
            case diagnosticSignatures
            case expirationDate
            case expired
            case iconAssetToken
            case icons
            case individualTesters
            case minOsVersion
            case perfPowerMetrics
            case preReleaseVersion
            case processingState
            case uploadedDate
            case usesNonExemptEncryption
            case version
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by id(s) of related 'app'
        case app([String])
        /// Filter by id(s) of related 'appStoreVersion'
        case appStoreVersion([String])
        /// Filter by attribute 'betaAppReviewSubmission.betaReviewState'
        case betaAppReviewSubmission_betaReviewState([BetaAppReviewSubmissionBetaReviewState])
        /// Filter by id(s) of related 'betaGroups'
        case betaGroups([String])
        /// Filter by attribute 'buildAudienceType'
        case buildAudienceType([BuildAudienceType])
        /// Filter by attribute 'expired'
        case expired([String])
        /// Filter by id(s)
        case id([String])
        /// Filter by id(s) of related 'preReleaseVersion'
        case preReleaseVersion([String])
        /// Filter by attribute 'preReleaseVersion.platform'
        case preReleaseVersion_platform([PreReleaseVersionPlatform])
        /// Filter by attribute 'preReleaseVersion.version'
        case preReleaseVersion_version([String])
        /// Filter by attribute 'processingState'
        case processingState([ProcessingState])
        /// Filter by attribute 'usesNonExemptEncryption'
        case usesNonExemptEncryption([String])
        /// Filter by attribute 'version'
        case version([String])

        public enum BetaAppReviewSubmissionBetaReviewState: String, ParameterValue, CaseIterable {
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case rejected = "REJECTED"
            case approved = "APPROVED"
        }

        public enum BuildAudienceType: String, ParameterValue, CaseIterable {
            case internalOnly = "INTERNAL_ONLY"
            case appStoreEligible = "APP_STORE_ELIGIBLE"
        }

        public enum PreReleaseVersionPlatform: String, ParameterValue, CaseIterable {
            case iOS = "IOS"
            case macOS = "MAC_OS"
            case tvOS = "TV_OS"
        }

        public enum ProcessingState: String, ParameterValue, CaseIterable {
            case processing = "PROCESSING"
            case failed = "FAILED"
            case invalid = "INVALID"
            case valid = "VALID"
        }
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case app, appEncryptionDeclaration, appStoreVersion, betaAppReviewSubmission, betaBuildLocalizations, buildBetaDetail, icons, individualTesters, preReleaseVersion
    }

    /**
     Attributes by which to sort.
     */
    public enum Sort: String, SortParameter {
        case preReleaseVersionAscending = "preReleaseVersion"
        case preReleaseVersionDescending = "-preReleaseVersion"
        case uploadedDateAscending = "uploadedDate"
        case uploadedDateDescending = "-uploadedDate"
        case versionAscending = "version"
        case versionDescending = "-version"
    }

    /**
     Number of included related resources to return.
     */
    public enum Limit: LimitParameter {
        /// Maximum resources per page - maximum 200
        case limit(Int)
        /// Maximum number of related individualTesters returned (when they are included) - maximum 50
        case individualTesters(Int)
        /// Maximum number of related betaBuildLocalizations returned (when they are included) - maximum 50
        case betaBuildLocalizations(Int)
        /// Maximum number of related icons returned (when they are included) - maximum 50
        case icons(Int)
    }
}
