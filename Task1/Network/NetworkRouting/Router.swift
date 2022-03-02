//

import Foundation

class Router<EndPoint: EndPointType> {
    
    private var urlTask: URLSessionTask?
    
    private func configureRequest(from endPoint: EndPoint) throws -> URLRequest {
        let baseURL = endPoint.baseURL
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endPoint.path), timeoutInterval: 10.0)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        do {
            switch endPoint.task {
            case .request(let urlParams, let headers):
                try configureHTTPParameters(urlRequest: &urlRequest, urlParams: urlParams, headers: headers)
            case .requestWithImage(let media, let urlParams, let headers):
                try configureHTTPParametersWithImage(urlRequest: &urlRequest, urlParams: urlParams, headers: headers, media: media)
            }
            return urlRequest
        } catch  {
            throw error
        }
    }
    private func configureHTTPParameters(urlRequest: inout URLRequest,urlParams: HTTPParameters?, headers: [String:String]?) throws {
        do {
                try HTTPURLParameterEncoder.encode(urlRequest: &urlRequest, httpParameters: urlParams, httpHeader: headers)
        } catch {
            throw error
        }
    }
    
    private func configureHTTPParametersWithImage(urlRequest: inout URLRequest,urlParams: HTTPParameters?, headers: [String:String]?, media: [MediaModel]) throws {
        do {
            try HTTPURLParameterEncoder.encodeWithImage(urlRequest: &urlRequest, httpParameters: urlParams, httpHeader: headers, media: media)
        } catch {
            throw error
        }
    }
}

extension Router: NetworkRouter {
    
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) {
        do {
            let urlRquest = try configureRequest(from: endPoint)

            urlTask = URLSession.shared.dataTask(with: urlRquest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil,nil,error)
        }
        urlTask?.resume()
    }
    
    func cancel() {
        urlTask?.cancel()
    }
}
