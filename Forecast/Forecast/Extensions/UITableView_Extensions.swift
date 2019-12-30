//
//  UITableView_Extensions.swift
//  Forecast
//
//  Created by Sebastien Gohier on 29/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import UIKit


extension UITableView {

    func dequeueReusableCell<T: Identifiable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func registerReusable<T: UITableViewCell>(_: T.Type) where T: Nibable {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
}
