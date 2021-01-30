public extension Request {
    /**
      # Replace the List of Visible Apps for a User
      Replace the list of apps a user on your team can see.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/replace_the_list_of_visible_apps_for_a_user>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func replaceVisibleAppsForUser(id: String,
                                          requestBody: UserVisibleAppsLinkagesRequest) -> Request<EmptyResponse, ErrorResponse>
    {
        return .init(path: "/v1/users/\(id)/relationships/visibleApps", method: .patch, requestBody: requestBody)
    }
}
