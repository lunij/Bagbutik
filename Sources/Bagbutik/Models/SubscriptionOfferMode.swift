import Foundation

public enum SubscriptionOfferMode: String, Codable, CaseIterable {
    case payAsYouGo = "PAY_AS_YOU_GO"
    case payUpFront = "PAY_UP_FRONT"
    case freeTrial = "FREE_TRIAL"
}
