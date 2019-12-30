//
//  DayVM.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation


class DayVM {
    
    private var data: [ForecastByHour]
    var date: Date
    var temperature: Double
    var pluie: Double
    var humidite: Double
    var ventMoyen: Double
    var nebulosite: Double
        
    init(_ data: [ForecastByHour]) {
        self.data = data
        self.date = data.first?.date ?? Date()
        let count = Double(data.count)
        self.temperature = data.reduce(0.0, {$0 + $1.temperature}) / count
        self.pluie = data.reduce(0.0, {$0 + $1.pluie}) / count
        self.humidite = data.reduce(0.0, {$0 + $1.humidite}) / count
        self.ventMoyen = data.reduce(0.0, {$0 + $1.ventMoyen}) / count
        self.nebulosite = data.reduce(0.0, {$0 + $1.nebulosite}) / count
    }
}
