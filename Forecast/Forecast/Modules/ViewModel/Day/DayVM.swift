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
    private var date: Date
    private var temperature: Double
    private var pluie: Double
    private var humidite: Double
    private var ventMoyen: Double
    private var nebulosite: Double
        
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
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    func getTemperature() -> String {
        return String(format: "%.f ºC", temperature - 273.15)
    }

    func getPluie() -> String {
        return String(format: "%.f mm", pluie * 10)
    }

    func getHumidite() -> String {
        return String(format: "%.f %%", humidite )
    }

    func getVentMoyen() -> String {
        return String(format: "%.f m/s", ventMoyen)
    }

    func getNebulosite() -> String {
        switch nebulosite {
        case 0..<30: return "ensoleillé"
        case 30..<60: return "nuageux"
        default: return "très nuageux"
        }
    }

}
