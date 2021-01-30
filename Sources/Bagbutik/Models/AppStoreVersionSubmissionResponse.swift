import Foundation

public struct AppStoreVersionSubmissionResponse: Codable {
    public let data: AppStoreVersionSubmission
    public let links: DocumentLinks

    public init(data: AppStoreVersionSubmission, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
