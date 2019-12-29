//
//  WeekView.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit

class WeekView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isRefreshing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(notification:)), name: LocationManager.shared.notificationName, object: nil)
    }
    
    /// Handler to observe notification events from LocationManager.
    @objc private func locationAvailable(notification: Notification) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        WSForecast().getForecastList() { list in
            guard let list = list else { return }
            print(list)
            self.isRefreshing = false
        }
    }
    
}

extension WeekView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
