//
//  WeekVM.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation


class WeekVM {
    
    private var data = [DayVM]()
    
    // MARK: Events
    /// Callback to pass the selected day.
    var selected: (DayVM) -> () = { _ in }
    /// Callback to reload the table.
    var reloadTable: () -> () = { }
    
    var numberOfRows = 0
    
    /// Method call to inform the view model to refresh the data.
    func refreshScreen() {
        data.removeAll()
        WSForecast().getForecastList() { [weak self] list in
            guard let list = list else { return }
            print(list)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            var listByDay = [String: [ForecastByHour]]()
            list.forEach({ forecastByHour in
                let strDay = dateFormatter.string(from: forecastByHour.date)
                if listByDay[strDay] == nil {
                    listByDay[strDay] = []
                }
                listByDay[strDay]?.append(forecastByHour)
            })
            let data = listByDay.map{ DayVM($0.value) }
            self?.data = data.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
            self?.numberOfRows = data.count
            self?.reloadTable()
        }
    }
    
    func dayVM(for indexPath: IndexPath) -> DayVM {
        return data[indexPath.row]
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        selected(data[indexPath.row])
    }
}
