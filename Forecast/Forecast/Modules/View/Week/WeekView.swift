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
    
    private var viewModel = WeekVM()
    private var isRefreshing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshScreen))
        tableView.registerReusable(WeekCell.self)
        observeEvents()
    }
    
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.isRefreshing = false
            }
        }
        
        viewModel.selected = { [weak self] dayVM in
            DispatchQueue.main.async {
                self?.navigateToDay(dayVM)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(notification:)), name: LocationManager.shared.notificationName, object: nil)
    }
    
    /// Refresh the screen when refresh button is pressed.
    @objc private func refreshScreen() {
        isRefreshing = true
        viewModel.refreshScreen()
    }
    
    /// Handler to observe notification events from LocationManager.
    @objc private func locationAvailable(notification: Notification) {
        guard !isRefreshing else { return }
        refreshScreen()
    }
    
}

extension WeekView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeekCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(viewModel.dayVM(for: indexPath))
        return cell
    }
    
}

extension WeekView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }
}

// MARK: Routing
extension WeekView {
    
    private func navigateToDay(_ viewModel: DayVM) {
        let controller = DayView(nibName: "DayView", bundle: nil)
        controller.modalPresentationStyle = .fullScreen
        controller.viewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
