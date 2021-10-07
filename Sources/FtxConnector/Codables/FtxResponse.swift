import Foundation

public struct FtxResponse<T>: Codable, Equatable where T: Codable & Equatable {
    public let success: Bool
    public let result: T
}
