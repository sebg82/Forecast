//
//  WeekCell.swift
//  Forecast
//
//  Created by Sebastien Gohier on 29/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit

final class WeekCell: UITableViewCell, Nibable {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var pluie: UILabel!
    @IBOutlet weak var humidite: UILabel!
    @IBOutlet weak var ventMoyen: UILabel!
    @IBOutlet weak var nebulosite: UILabel!
    
    func configure(_ viewModel: DayVM) {
        date.text = viewModel.getDate()
        temperature.text = viewModel.getTemperature()
        pluie.text = viewModel.getPluie()
        humidite.text = viewModel.getHumidite()
        ventMoyen.text = viewModel.getVentMoyen()
        nebulosite.text = viewModel.getNebulosite()
    }
}
