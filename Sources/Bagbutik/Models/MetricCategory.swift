import Foundation

public enum MetricCategory: String, Codable, CaseIterable {
    case hang = "HANG"
    case launch = "LAUNCH"
    case memory = "MEMORY"
    case disk = "DISK"
    case battery = "BATTERY"
    case termination = "TERMINATION"
    case animation = "ANIMATION"
}
