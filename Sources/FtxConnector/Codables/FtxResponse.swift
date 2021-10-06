import Foundation

public struct FtxResponse<T>: Codable where T: Codable {
    public let success: Bool
    public let result: T
}
