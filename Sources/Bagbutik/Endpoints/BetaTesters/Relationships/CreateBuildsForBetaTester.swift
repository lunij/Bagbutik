public extension Request {
    /**
      # Individually Assign a Beta Tester to Builds
      Individually assign a beta tester to a build.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/individually_assign_a_beta_tester_to_builds>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func createBuildsForBetaTester(id: String,
                                          requestBody: BetaTesterBuildsLinkagesRequest) -> Request<EmptyResponse, ErrorResponse>
    {
        return .init(path: "/v1/betaTesters/\(id)/relationships/builds", method: .post, requestBody: requestBody)
    }
}
