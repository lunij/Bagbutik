public extension Request {
    /**
      # Commit an App Store Review Attachment
      Commit an app screenshot after uploading it to the App Store.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/commit_an_app_store_review_attachment>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateAppStoreReviewAttachment(id: String,
                                               requestBody: AppStoreReviewAttachmentUpdateRequest) -> Request<AppStoreReviewAttachmentResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreReviewAttachments/\(id)", method: .patch, requestBody: requestBody)
    }
}
