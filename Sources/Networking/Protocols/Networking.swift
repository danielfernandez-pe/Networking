import Foundation

public protocol Endpoint {
    var url: String { get }
    var path: String { get }
    var header: [String: Any] { get }
    var body: [String: Any] { get }
}

public protocol Networking {
    func get(endpoint: Endpoint) -> Data
    func post(endpoint: Endpoint) -> Data
}
