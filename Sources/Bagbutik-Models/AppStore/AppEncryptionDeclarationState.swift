import Bagbutik_Core
import Foundation

/**
 # AppEncryptionDeclarationState
 Strings that represent the review or acceptance status of an app encryption declaration submitted to Apple.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/appencryptiondeclarationstate>
 */
public enum AppEncryptionDeclarationState: String, Codable, CaseIterable {
    case created = "CREATED"
    case inReview = "IN_REVIEW"
    case approved = "APPROVED"
    case rejected = "REJECTED"
    case invalid = "INVALID"
    case expired = "EXPIRED"
}
