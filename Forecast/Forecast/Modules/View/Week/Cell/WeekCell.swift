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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ viewModel: DayVM) {
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
