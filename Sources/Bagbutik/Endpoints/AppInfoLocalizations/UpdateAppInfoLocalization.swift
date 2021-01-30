public extension Request {
    /**
      # Modify an App Info Localization
      Modify localized app-level information for a particular language.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_info_localization>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateAppInfoLocalization(id: String,
                                          requestBody: AppInfoLocalizationUpdateRequest) -> Request<AppInfoLocalizationResponse, ErrorResponse>
    {
        return .init(path: "/v1/appInfoLocalizations/\(id)", method: .patch, requestBody: requestBody)
    }
}
