public extension Request {
    /**
      # Assign Individual Testers to a Build
      Enable a beta tester who is not a part of a beta group to test a build.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/assign_individual_testers_to_a_build>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func createIndividualTestersForBuild(id: String,
                                                requestBody: BuildIndividualTestersLinkagesRequest) -> Request<EmptyResponse, ErrorResponse>
    {
        return .init(path: "/v1/builds/\(id)/relationships/individualTesters", method: .post, requestBody: requestBody)
    }
}
