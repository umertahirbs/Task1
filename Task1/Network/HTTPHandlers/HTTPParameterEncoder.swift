//

import Foundation

typealias HTTPParameters = [String:Any]

enum EncodingError: String,Error {
    
    case encodingFailed     = "HTTP parameters are nil"
    case encodeURLMissing   = "url to encode is nil"
}
protocol HTTPParameterEncoder {
    
    static  func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters?,httpHeader:[String:String]?) throws
    static  func encodeWithImage(urlRequest: inout URLRequest, httpParameters: HTTPParameters?,httpHeader:[String:String]?,media: [MediaModel]) throws
}
