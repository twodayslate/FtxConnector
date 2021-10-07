import Foundation

/// https://docs.ftx.com/?csharp#get-account-information
public struct FtxAccount: Codable, Equatable {
    /// whether or not the account is a registered backstop liquidity provider
    public let backstopProvider: Bool
    /// amount of collateral
    public let collateral: Double
    /// amount of free collateral
    public let freeCollateral: Double
    /// average of initialMarginRequirement for individual futures, weighed by position notional. Cannot open new positions if openMarginFraction falls below this value.
    public let initialMarginRequirement: Double
    /// Max account leverage
    public let leverage: Double
    /// True if the account is currently being liquidated
    public let liquidating: Bool
    /// Average of maintenanceMarginRequirement for individual futures, weighed by position notional. Account enters liquidation mode if margin fraction falls below this value.
    public let maintenanceMarginRequirement: Double
    public let makerFee: Double
    public let takerFee: Double
    /// ratio between total account value and total account position notional.
    public let marginFraction: Double?
    /// Ratio between total realized account value and total open position notional
    public let openMarginFraction: Double?
    /// total value of the account, using mark price for positions
    public let totalAccountValue: Double
    /// total size of positions held by the account, using mark price
    public let totalPositionSize: Double
    public let username: String
    public let positions: [FtxPosition]
}
