//
//  Identifiable.swift
//  Forecast
//
//  Created by Sebastien Gohier on 29/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit


protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {}
