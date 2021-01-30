public extension Request {
    /**
      # Create an App Store Version Submission
      Submit an App Store version to App Review.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_store_version_submission>

      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func createAppStoreVersionSubmission(requestBody: AppStoreVersionSubmissionCreateRequest) -> Request<AppStoreVersionSubmissionResponse, ErrorResponse> {
        return .init(path: "/v1/appStoreVersionSubmissions", method: .post, requestBody: requestBody)
    }
}
