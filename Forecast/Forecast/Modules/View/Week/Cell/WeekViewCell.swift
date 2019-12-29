//
//  WeekViewCell.swift
//  Forecast
//
//  Created by Sebastien Gohier on 29/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit

final class WeekViewCell: UITableViewCell, Nibable {
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var pluie: UILabel!
    @IBOutlet weak var humidite: UILabel!
    @IBOutlet weak var ventMoyen: UILabel!
    @IBOutlet weak var nebulosite: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        temperature.text = "1"
        pluie.text = "2"
        humidite.text = "3"
        ventMoyen.text = "4"
        nebulosite.text = "5"
    }
}
