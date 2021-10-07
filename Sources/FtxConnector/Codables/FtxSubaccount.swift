import Foundation

public struct FtxSubaccount: Codable, Equatable {
    /// subaccount name
    public let nickname: String
    /// whether the subaccount can be deleted
    public let deletable: Bool
    /// whether the nickname of the subaccount can be changed
    public let editable: Bool
    /// whether the subaccount was created for a competition
    public let competition: Bool
    
    public var encodedNickname: String {
        return self.nickname.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? self.nickname
    }
}
