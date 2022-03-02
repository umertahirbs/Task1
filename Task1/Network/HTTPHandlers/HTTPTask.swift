//

import Foundation

enum HTTPTask {
    case request(urlParams: HTTPParameters?,headers: [String: String]? = nil)
    case requestWithImage(media: [MediaModel], urlParams: HTTPParameters?,headers: [String: String]? = nil)
}
