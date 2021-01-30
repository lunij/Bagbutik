import Foundation

public enum UserRole: String, Codable, CaseIterable {
    case admin = "ADMIN"
    case finance = "FINANCE"
    case technical = "TECHNICAL"
    case accountHolder = "ACCOUNT_HOLDER"
    case readOnly = "READ_ONLY"
    case sales = "SALES"
    case marketing = "MARKETING"
    case appManager = "APP_MANAGER"
    case developer = "DEVELOPER"
    case accessToReports = "ACCESS_TO_REPORTS"
    case customerSupport = "CUSTOMER_SUPPORT"
}
