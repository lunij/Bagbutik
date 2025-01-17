import Bagbutik_Core
import Foundation

/**
 # CapabilityType
 String that represents an app's capability type.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/capabilitytype>
 */
public enum CapabilityType: String, Codable, CaseIterable {
    case iCloud = "ICLOUD"
    case inAppPurchase = "IN_APP_PURCHASE"
    case gameCenter = "GAME_CENTER"
    case pushNotifications = "PUSH_NOTIFICATIONS"
    case wallet = "WALLET"
    case interAppAudio = "INTER_APP_AUDIO"
    case maps = "MAPS"
    case associatedDomains = "ASSOCIATED_DOMAINS"
    case personalVpn = "PERSONAL_VPN"
    case appGroups = "APP_GROUPS"
    case healthKit = "HEALTHKIT"
    case homeKit = "HOMEKIT"
    case wirelessAccessoryConfiguration = "WIRELESS_ACCESSORY_CONFIGURATION"
    case applePay = "APPLE_PAY"
    case dataProtection = "DATA_PROTECTION"
    case siriKit = "SIRIKIT"
    case networkExtensions = "NETWORK_EXTENSIONS"
    case multipath = "MULTIPATH"
    case hotSpot = "HOT_SPOT"
    case nfcTagReading = "NFC_TAG_READING"
    case classKit = "CLASSKIT"
    case autofillCredentialProvider = "AUTOFILL_CREDENTIAL_PROVIDER"
    case accessWifiInformation = "ACCESS_WIFI_INFORMATION"
    case networkCustomProtocol = "NETWORK_CUSTOM_PROTOCOL"
    case coremediaHlsLowLatency = "COREMEDIA_HLS_LOW_LATENCY"
    case systemExtensionInstall = "SYSTEM_EXTENSION_INSTALL"
    case userManagement = "USER_MANAGEMENT"
    case appleIdAuth = "APPLE_ID_AUTH"
}
