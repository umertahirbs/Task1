//

import Foundation

let BASEURL = "https://vyod.manaknightdigital.com/"

enum Api {
    case login(params : [String:Any])
    case register(params : [String:Any])
    case verifyAccount(params : [String:Any])
    case forgot(params : [String:Any])
    case validateReset(params : [String:Any])
    case resetPasswprd(params : [String:Any])


}

extension Api: EndPointType {
    
    private var envBaseURL: String {
        switch self {
        default:
            switch NetworkHandler.environment {
            case .production, .staging:
                return "https://vyod.manaknightdigital.com/"
            case .development:
                return "https://vyod.manaknightdigital.com"
            }
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: envBaseURL) else {fatalError("Invalid Base URL.")}
        return url
    }
    
    var path: String {
        
        switch self {
        case .login:
            return "member/api/login"
        case .register:
            return "member/api/register"
        case .verifyAccount:
            return "member/api/verify-account"
        case .forgot:
            return "member/api/forgot"
        case .validateReset:
            return "member/api/validate-reset-code"
        case .resetPasswprd:
            return "member/api/reset-password"
        
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register , .verifyAccount, .forgot, .validateReset, .resetPasswprd:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .login(let params):
            return .request(urlParams: params)
        case .register(let params):
            return .request(urlParams: params)
        case .verifyAccount(let params):
            return .request(urlParams: params)
        case .forgot(let params):
            return .request(urlParams: params)
        case .validateReset(let params):
            return .request(urlParams: params)
        case .resetPasswprd(let params):
            return .request(urlParams: params)
        
        }
        
    }
}

