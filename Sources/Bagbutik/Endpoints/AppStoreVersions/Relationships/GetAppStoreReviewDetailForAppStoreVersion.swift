public extension Request {
    /**
      # Read the App Store Review Details Resource Information of an App Store Version
      Get the details you provide to App Review so they can test your app.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_store_review_details_resource_information_of_an_app_store_version>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter includes: Relationship data to include in the response
      - Parameter limit: Maximum number of related appStoreReviewAttachments returned (when they are included) - maximum 50
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func getAppStoreReviewDetailForAppStoreVersion(id: String,
                                                          fields: [GetAppStoreReviewDetailForAppStoreVersion.Field]? = nil,
                                                          includes: [GetAppStoreReviewDetailForAppStoreVersion.Include]? = nil,
                                                          limit: Int? = nil) -> Request<AppStoreReviewDetailResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreVersions/\(id)/appStoreReviewDetail", method: .get, parameters: .init(fields: fields,
                                                                                                              includes: includes,
                                                                                                              limit: limit))
    }
}

public enum GetAppStoreReviewDetailForAppStoreVersion {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appStoreReviewAttachments
        case appStoreReviewAttachments([AppStoreReviewAttachments])
        /// The fields to include for returned resources of type appStoreReviewDetails
        case appStoreReviewDetails([AppStoreReviewDetails])

        public enum AppStoreReviewAttachments: String, ParameterValue, CaseIterable {
            case appStoreReviewDetail
            case assetDeliveryState
            case fileName
            case fileSize
            case sourceFileChecksum
            case uploadOperations
            case uploaded
        }

        public enum AppStoreReviewDetails: String, ParameterValue, CaseIterable {
            case appStoreReviewAttachments
            case appStoreVersion
            case contactEmail
            case contactFirstName
            case contactLastName
            case contactPhone
            case demoAccountName
            case demoAccountPassword
            case demoAccountRequired
            case notes
        }
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case appStoreReviewAttachments
    }
}
