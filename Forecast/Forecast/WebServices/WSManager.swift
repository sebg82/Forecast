//
//  WSManager.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation

struct WSConstants {
    static let baseURL = "http://www.infoclimat.fr"
    static let api = "/public-api/gfs/json?"
    static let auth = "AhhRRlIsASNWewQzVCIKI1Q8BjNaLAkuB3sFZls%2BVisGbQNiBmZXMVE%2FUSwPIAs9WHUCYQoxAzNXPAR8XS9VNAJoUT1SOQFmVjkEYVR7CiFUegZnWnoJLgdlBWJbP1YrBmcDZQZkVytRP1E2DzYLIVhqAmIKMQMkVysEYl01VTECZlExUjYBYlY8BGBUZgohVHgGY1owCTEHYgVmW2NWMQY0A2cGYVc2UW1RNw86CyFYYgJmCj0DPFc8BGJdOVU%2FAn5RKlJIARBWJAQmVCYKa1QhBntaMAlvBzA%3D"
    static let c = "cacd163da97627ded427b0821071c432"
}

class WSManager: NSObject {
    
    static let shared = WSManager()
    
    typealias WSCompletionBlock = (_ data: [String:AnyObject]?, _ error: Error?) -> Void
    
    enum HTTPMethodType: String {
        case POST
        case GET
    }
    
    func requestAPI(url: String, parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping WSCompletionBlock) {
        
        let urlEscaped = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlAuth = "\(urlEscaped)&_auth=\(WSConstants.auth)&_c=\(WSConstants.c)"
        var request = URLRequest(url: URL(string: urlAuth)!)
        request.httpMethod = httpMethodType.rawValue
            
        if let parameter = parameter {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                error == nil,
                let httpStatus = response as? HTTPURLResponse,
                httpStatus.statusCode == 200
            else { return completion(nil, error) }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    completion(json, nil)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        task.resume()
    }
}
