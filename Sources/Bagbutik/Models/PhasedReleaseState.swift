import Foundation

public enum PhasedReleaseState: String, Codable, CaseIterable {
    case inactive = "INACTIVE"
    case active = "ACTIVE"
    case paused = "PAUSED"
    case complete = "COMPLETE"
}
