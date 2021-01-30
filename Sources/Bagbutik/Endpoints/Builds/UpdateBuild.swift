public extension Request {
    /**
      # Modify a Build
      Expire a build or change its encryption exemption setting.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/modify_a_build>

      - Parameter id: An opaque resource ID that uniquely identifies the resource
      - Parameter requestBody: The data for the request
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateBuild(id: String,
                            requestBody: BuildUpdateRequest) -> Request<BuildResponse, ErrorResponse>
    {
        return .init(path: "/v1/builds/\(id)", method: .patch, requestBody: requestBody)
    }
}
