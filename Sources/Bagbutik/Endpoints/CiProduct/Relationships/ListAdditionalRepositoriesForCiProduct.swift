public extension Request {
    /**
      # List All Additional Repositories for an Xcode Cloud Product
      List all additional Git repositories you associated with an Xcode Cloud product.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_additional_repositories_for_an_xcode_cloud_product>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter limit: Maximum resources per page - maximum 200
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listAdditionalRepositoriesForCiProduct(id: String,
                                                       fields: [ListAdditionalRepositoriesForCiProduct.Field]? = nil,
                                                       filters: [ListAdditionalRepositoriesForCiProduct.Filter]? = nil,
                                                       limit: Int? = nil) -> Request<ScmRepositoriesResponse, ErrorResponse>
    {
        return .init(path: "/v1/ciProducts/\(id)/additionalRepositories", method: .get, parameters: .init(fields: fields,
                                                                                                          filters: filters,
                                                                                                          limit: limit))
    }
}

public enum ListAdditionalRepositoriesForCiProduct {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type scmRepositories
        case scmRepositories([ScmRepositories])

        public enum ScmRepositories: String, ParameterValue, CaseIterable {
            case defaultBranch
            case gitReferences
            case httpCloneUrl
            case lastAccessedDate
            case ownerName
            case pullRequests
            case repositoryName
            case scmProvider
            case sshCloneUrl
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by id(s)
        case id([String])
    }
}