//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject{
    
    associatedtype EndPoint: EndPointType
    
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion)
    func cancel()
}
