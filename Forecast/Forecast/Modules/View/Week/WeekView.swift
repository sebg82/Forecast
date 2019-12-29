//
//  WeekView.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit

class WeekView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WSForecast().getForecastList() { list in
            guard let list = list else { return }
            print(list)
        }
    }


}
