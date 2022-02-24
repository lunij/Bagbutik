public extension Platform {
    /// A pretty name for the case.
    var prettyName: String {
        switch self {
        case .iOS: return "iOS"
        case .macOS: return "macOS"
        case .tvOS: return "tvOS"
        }
    }
}
