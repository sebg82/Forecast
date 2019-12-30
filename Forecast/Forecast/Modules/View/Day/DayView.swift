//
//  DayView.swift
//  Forecast
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit

class DayView: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var pluie: UILabel!
    @IBOutlet weak var humidite: UILabel!
    @IBOutlet weak var ventMoyen: UILabel!
    @IBOutlet weak var nebulosite: UILabel!
    
    var viewModel: DayVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(viewModel)
    }

    func configure(_ viewModel: DayVM?) {
        guard let viewModel = viewModel else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        date.text = dateFormatter.string(from: viewModel.date)
        temperature.text = String(format: "%.2f", (viewModel.temperature - 32) * 5 / 9)
        pluie.text = String(format: "%.2f", viewModel.pluie)
        humidite.text = String(format: "%.2f", viewModel.humidite)
        ventMoyen.text = String(format: "%.2f", viewModel.ventMoyen)
        nebulosite.text = String(format: "%.2f", viewModel.nebulosite)
    }
}
