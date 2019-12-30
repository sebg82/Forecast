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
        guard let viewModel = viewModel else { return }
        configure(viewModel)
    }

    func configure(_ viewModel: DayVM) {
        date.text = viewModel.getDate()
        temperature.text = viewModel.getTemperature()
        pluie.text = viewModel.getPluie()
        humidite.text = viewModel.getHumidite()
        ventMoyen.text = viewModel.getVentMoyen()
        nebulosite.text = viewModel.getNebulosite()
    }
}
