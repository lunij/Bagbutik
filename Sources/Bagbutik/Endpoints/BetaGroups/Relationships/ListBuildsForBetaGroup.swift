public extension Request {
    enum ListBuildsForBetaGroup {
        /**
         Fields to return for included related types.
         */
        public enum Field: FieldParameter {
            /// The fields to include for returned resources of type builds
            case builds([Builds])

            public enum Builds: String, ParameterValue, CaseIterable {
                case app
                case appEncryptionDeclaration
                case appStoreVersion
                case betaAppReviewSubmission
                case betaBuildLocalizations
                case betaGroups
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
    }

    /**
      # List All Builds for a BetaGroup
      Get a list of builds associated with a specific beta group.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_for_a_betagroup>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter fields: Fields to return for included related types
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listBuildsForBetaGroup(id: String,
                                       fields: [ListBuildsForBetaGroup.Field]? = nil,
                                       limit: Int? = nil) -> Request<BuildsResponse, ErrorResponse>
    {
        return .init(path: "/v1/betaGroups/\(id)/builds", method: .get, parameters: .init(fields: fields,
                                                                                          limit: limit))
    }
}
