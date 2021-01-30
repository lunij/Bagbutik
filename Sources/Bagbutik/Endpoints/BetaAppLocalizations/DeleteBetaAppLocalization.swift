public extension Request {
    /**
      # Delete a Beta App Localization
      Delete a beta app localization associated with an app.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/delete_a_beta_app_localization>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func deleteBetaAppLocalization(id: String) -> Request<EmptyResponse, ErrorResponse> {
        return .init(path: "/v1/betaAppLocalizations/\(id)", method: .delete)
    }
}
