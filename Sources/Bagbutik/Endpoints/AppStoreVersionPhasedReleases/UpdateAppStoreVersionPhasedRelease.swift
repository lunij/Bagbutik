public extension Request {
    /**
      # Modify an App Store Version Phased Release
      Pause or resume a phased release, or immediately release an app.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_store_version_phased_release>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateAppStoreVersionPhasedRelease(id: String,
                                                   requestBody: AppStoreVersionPhasedReleaseUpdateRequest) -> Request<AppStoreVersionPhasedReleaseResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreVersionPhasedReleases/\(id)", method: .patch, requestBody: requestBody)
    }
}
