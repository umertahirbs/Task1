//

import Foundation

typealias AuthCompletionBlock = (Result<AuthRM, String>) -> Void
typealias ForgotPassCompletionBlock = (Result<ErrorRM, String>) -> Void

struct AuthService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension AuthService {
    func loginResult(params: [String : String], completion: @escaping AuthCompletionBlock) {
        
        networkHandler.fetchData(Api.login(params: params)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponse = try jsonDecoder.decode(AuthRM.self, from: response)

                    completion(.success(apiResponse))
                } catch _ {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }

            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
    
    func register(params: [String : String], completion: @escaping AuthCompletionBlock) {
        
        networkHandler.fetchData(Api.register(params: params)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponse = try jsonDecoder.decode(AuthRM.self, from: response)

                    completion(.success(apiResponse))
                } catch _ {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }

            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
    
    func verifyAccout(params: [String : String], completion: @escaping ForgotPassCompletionBlock) {
        
        networkHandler.fetchData(Api.verifyAccount(params: params)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponse = try jsonDecoder.decode(ErrorRM.self, from: response)

                    completion(.success(apiResponse))
                } catch _ {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }

            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
    
    
    func resetPaswd(params: [String : String], completion: @escaping ForgotPassCompletionBlock) {
        
        networkHandler.fetchData(Api.resetPasswprd(params: params)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponse = try jsonDecoder.decode(ErrorRM.self, from: response)

                    completion(.success(apiResponse))
                } catch _ {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }

            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
    
   
}
