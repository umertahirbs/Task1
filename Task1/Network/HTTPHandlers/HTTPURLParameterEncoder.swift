//

import Foundation

enum HTTPURLParameterEncoder: HTTPParameterEncoder{
    
    static func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters?,httpHeader:[String:String]?) throws{
        
        guard let urlToEcode = urlRequest.url else { throw EncodingError.encodeURLMissing}

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        if let headers = httpHeader{
            urlRequest.allHTTPHeaderFields = headers
        }

        if let httpParameter = httpParameters{
        guard let urlComponents = URLComponents(url: urlToEcode, resolvingAgainstBaseURL: false), !httpParameter.isEmpty else { return }
        
       
                // for raw data
                try urlRequest.httpBody = JSONSerialization.data(withJSONObject: httpParameter, options: [])
                    urlRequest.url = urlComponents.url
               
            
        }
        
         //for form-data
//        urlComponents.queryItems = [URLQueryItem]()
//        for (key,value) in httpParameters {
//            let item = URLQueryItem(name: key, value: "\(value)")
//            urlComponents.queryItems?.append(item)
//        }
        
    }
    
    static func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }

    static func encodeWithImage(urlRequest: inout URLRequest, httpParameters: HTTPParameters?,httpHeader:[String:String]?,media: [MediaModel]) throws{
        
        if let headers = httpHeader{
            urlRequest.allHTTPHeaderFields = headers
        }
       let imageKeyParam = ""
        let boundry = "Boundary-\(UUID().uuidString)"
        var body = Data()
        let boundaryPrefix = "--\(boundry)\r\n"

        body.append( boundaryPrefix.data(using: .utf8) ?? Data())
        body.append( "Content-Disposition: form-data; name=\"\(imageKeyParam)\"\r\n".data(using: .utf8) ?? Data())
        body.append( "Content-Type: application/json\r\n\r\n".data(using: .utf8) ?? Data())
        body.append( "\r\n\r\n".data(using: .utf8) ?? Data())

        var jsonBody = Data()
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: httpParameters ?? [:], options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
        }

        body.append(jsonBody)
        body.append( "\r\n".data(using: .utf8) ?? Data())


        for media in media.enumerated() {

            body.append( boundaryPrefix.data(using: .utf8) ?? Data())
            let filename = "\(media.offset)_\(media.element.filename)"
            body.append( "Content-Disposition: form-data; name=\"\(media.element.keyName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8) ?? Data())
            body.append( "Content-Type: \(media.element.mimeType)\r\n\r\n".data(using: .utf8) ?? Data())
            body.append(media.element.image_data)
            body.append( "\r\n".data(using: .utf8) ?? Data())
            //   body.append( "--\(boundry)--".data(using: .utf8) ?? Data())

        }

        body.append( "--\(boundry)--\r\n".data(using: .utf8) ?? Data())
        urlRequest.httpBody = body
        urlRequest.addValue("multipart/form-data; boundary=\(boundry)", forHTTPHeaderField: "Content-Type")
    }

}
