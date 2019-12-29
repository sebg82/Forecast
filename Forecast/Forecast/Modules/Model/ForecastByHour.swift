//
//  ForecastByHour.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation


struct ForecastByHour {

    var temperature: Double
    var pluie: Double
    var humidite: Double
    var ventMoyen: Double
    var nebulosite: Int

    init(attributes: [String: Any]) {
        self.temperature = (attributes["temperature"] as! [String:Double])["2m"]!
        self.pluie = attributes["pluie"] as! Double
        self.humidite = (attributes["humidite"] as! [String:Double])["2m"]!
        self.ventMoyen = (attributes["vent_moyen"] as! [String:Double])["10m"]!
        self.nebulosite = (attributes["nebulosite"] as! [String:Int])["totale"]!
    }
}
