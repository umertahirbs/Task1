//

import Foundation

enum NetworkEnvironment {
    
    case staging
    case production
    case development
}

enum NetworkResponse: String {
    
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
    case noNetwork              = "No Internet Connectivity"
}

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

typealias NetworkCompletionBlock = (Result<Data, String>)-> Void

struct NetworkHandler {
    
    static let environment: NetworkEnvironment = .production
    private var router = Router<Api>()
    
}
extension NetworkHandler {
    
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkResponse {
        switch urlResponse.statusCode {
        case 200...299,400:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkCompletionBlock) where EndPoint:EndPointType {
        
        guard NetworkReachability.shared.isConnected else {
            completion(.failure(NetworkResponse.noNetwork.rawValue))
            return
        }
        router.request(endPoint: endPoint as!
                        Api) {(data, response, error) in
            self.parseURLRequestData(data: data, response: response, error: error) { response in
                completion(response)
            }
        }
    }
    func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkCompletionBlock) {
        
        if let _ = error {
            completion(.failure(NetworkResponse.badRequest.rawValue))
            return
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkResponse.failed.rawValue))
            return
        }
        
        let networkResponse = parseHTTPResponse(httpURLResponse)
        switch networkResponse {
        case .success:
            guard let data = data else {
                completion(.failure(NetworkResponse.noData.rawValue))
                return
            }
            completion(.success(data))
        case .authenticationError:
            guard let data = data else {
                completion(.failure(NetworkResponse.noData.rawValue))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let apiResponse = try jsonDecoder.decode(ErrorRM.self, from: data)
                
                completion(.failure(apiResponse.message ?? "NO_VALUE"))
            } catch _ {
                completion(.failure(NetworkResponse.unableToDecode.rawValue))
            }
        default:
            completion(.failure(networkResponse.rawValue))
        }
    }
}
