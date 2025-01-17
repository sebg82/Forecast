//
//  WSForecast.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation
import CoreLocation

struct WSForecast {
    
    func getForecastList(completion: @escaping ([ForecastByHour]?) -> ()) {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            self.getForecastListMock() { result in
                completion(self.convert(result))
            }
        }
        
        let coordinate = LocationManager.shared.location
        getForecastListServer(at: coordinate) { result in
            switch result {
            case nil:
                self.getForecastListLocal(at: coordinate) { result in
                    completion(self.convert(result))
                }
            default:
                completion(self.convert(result))
            }
        }
    }
    
    private func convert(_ dic: [String:AnyObject]?) -> [ForecastByHour]? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let results = dic?.compactMap { (key, value) -> ForecastByHour? in
            guard let date = dateFormatter.date(from: key),
                let attributes = value as? [String:Any]
                else { return nil }
            return ForecastByHour(date, attributes: attributes)
        }
        
        return results
    }
    
    private func getForecastListServer(at coordinate: CLLocationCoordinate2D, completion: @escaping ([String:AnyObject]?) -> ()) {
        
        let url = WSConstants.baseURL + WSConstants.api + "_ll=\(coordinate.latitude),\(coordinate.longitude)"
        WSManager.shared.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let dic = response else { return completion(nil) }

            if let filePath = self.filePath(for: coordinate) {
                NSKeyedArchiver.archiveRootObject(dic, toFile: filePath)
            }
            
            if let createMockFile = Bundle.main.object(forInfoDictionaryKey: "CREATE_MOCK_FILE") as? Bool, createMockFile,
                let mockPath = self.filePathMock() {
                NSKeyedArchiver.archiveRootObject(dic, toFile: mockPath)
            }
            
            completion(dic)
        }
    }
    
    func getForecastListLocal(at coordinate: CLLocationCoordinate2D, completion: @escaping ([String:AnyObject]?) -> ()) {
        guard let filePath = filePath(for: coordinate),
            let result = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String:AnyObject]
            else { return completion(nil) }
        
        completion(result)
    }
    
    func getForecastListMock(completion: @escaping ([String:AnyObject]?) -> ()) {
        guard let mockPath = self.filePathMock(),
            let result = NSKeyedUnarchiver.unarchiveObject(withFile: mockPath) as? [String:AnyObject]
            else { return completion(nil) }
        
        completion(result)
    }
    
    private func filePath(for coordinate: CLLocationCoordinate2D) -> String? {
        let fileName = String(format: "%.2f-%.2f.json", coordinate.latitude, coordinate.longitude)
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDir?.appendingPathComponent(fileName).path
    }
    
    private func filePathMock() -> String? {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDir?.appendingPathComponent("mock.json").path
    }
}
