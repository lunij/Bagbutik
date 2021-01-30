public extension Request {
    enum ListBetaBuildLocalizationsForBuild {
        /**
         Fields to return for included related types.
         */
        public enum Field: FieldParameter {
            /// The fields to include for returned resources of type betaBuildLocalizations
            case betaBuildLocalizations([BetaBuildLocalizations])

            public enum BetaBuildLocalizations: String, ParameterValue, CaseIterable {
                case build
                case locale
                case whatsNew
            }
        }
    }

    /**
      # List All Beta Build Localizations of a Build
      Get a list of localized beta test information for a specific build.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_build_localizations_of_a_build>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter fields: Fields to return for included related types
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listBetaBuildLocalizationsForBuild(id: String,
                                                   fields: [ListBetaBuildLocalizationsForBuild.Field]? = nil,
                                                   limit: Int? = nil) -> Request<BetaBuildLocalizationsResponse, ErrorResponse>
    {
        return .init(path: "/v1/builds/\(id)/betaBuildLocalizations", method: .get, parameters: .init(fields: fields,
                                                                                                      limit: limit))
    }
}
