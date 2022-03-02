
import Foundation
import Network

class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    var isConnected = true {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Notification"), object: NetworkReachability.shared.isConnected)
        }
    }
    
    private init(){
        startCheckingForConnectivity()
    }

    private func startCheckingForConnectivity() {
        let networkMoniter = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        networkMoniter.start(queue: queue)
        networkMoniter.pathUpdateHandler = { path in
            NetworkReachability.shared.isConnected = path.status == .satisfied
        }
    }
}
