import Foundation

public struct FtxPosition: Codable {
    /// Amount that was paid to enter this position, equal to size * entry_price. Positive if long, negative if short.
    public let cost: Double
    public let cumulativeBuySize: Double?
    public let cumulativeSellSize: Double?
    /// Average cost of this position after pnl was last realized: whenever unrealized pnl gets realized, this field gets set to mark price, unrealizedPnL is set to 0, and realizedPnl changes by the previous value for unrealizedPnl.
    public let entryPrice: Double?
    public let estimatedLiquidationPrice: Double?
    /// future name
    public let future: String
    /// Minimum margin fraction for opening new positions
    public let initialMarginRequirement: Double
    /// Cumulative size of all open bids
    public let longOrderSize: Double
    /// Minimum margin fraction to avoid liquidations
    public let maintenanceMarginRequirement: Double
    /// Size of position. Positive if long, negative if short.
    public let netSize: Double
    /// Maximum possible absolute position size if some subset of open orders are filled
    public let openSize: Double
    public let realizedPnl: Double
    public let recentAverageOpenPrice: Double?
    public let recentBreakEvenPrice: Double?
    public let recentPnl: Double?
    /// Cumulative size of all open offers
    public let shortOrderSize: Double
    /// sell if short, buy if long
    public let side: String
    /// Absolute value of netSize
    public let size: Double
    public let unrealizedPnl: Double
    /**
     * Is equal to:
     * * For PRESIDENT: initialMarginRequirement * openSize * (risk price)
     * * For MOVE: initialMarginRequirement * openSize * (index price)
     * * Otherwise: initialMarginRequirement * openSize * (mark price)
     */
    public let collateralUsed: Double
}
