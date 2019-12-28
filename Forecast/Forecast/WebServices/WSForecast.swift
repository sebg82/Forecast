//
//  WSForecast.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation

struct WSForecast {
    
    func getForecastList(completion: @escaping ([ForecastByHour]?, _ error: Error?)->()) {
        let userLat = "48.85341"
        let userLong = "2.3488"
        
        let url = WSConstants.baseURL + WSConstants.api + "_ll=\(userLat),\(userLong)"
        WSManager.shared.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            if let filePath = documentDir?.appendingPathComponent("forecast.json").path {
                NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
            }
            
            if Bundle.main.object(forInfoDictionaryKey: "CREATE_MOCK_FILE") != nil {
                if let mockPath = documentDir?.appendingPathComponent("mock.json").path {
                    NSKeyedArchiver.archiveRootObject(data, toFile: mockPath)
                }
            }

            completion(nil, nil)
        }
    }
}
