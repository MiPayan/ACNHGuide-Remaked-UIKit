//
//  OwnedDashboardViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class OwnedDashboardViewController: UIViewController {
    
    private let ownedDashboardViewModel = OwnedDashboardViewModel()
    private lazy var dashboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "DashboardCell")
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpUpdateDataHandler()
        ownedDashboardViewModel.getDatas()
    }
    
    func setUpUpdateDataHandler() {
        ownedDashboardViewModel.successHandler = {
            self.dashboardTableView.reloadData()
        }
    }
}

private extension OwnedDashboardViewController {
    func addSubviews() {
        view.addSubview(dashboardTableView)
        NSLayoutConstraint.activate([
            dashboardTableView.topAnchor.constraint(equalTo: view.topAnchor),
            dashboardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dashboardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dashboardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension OwnedDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dashboardCell = tableView.dequeueReusableCell(
            withIdentifier: "DashboardCell",
            for: indexPath
        ) as? DashboardTableViewCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0: dashboardCell.configureFishCell(fishData: ownedDashboardViewModel.fishData)
        case 1: dashboardCell.configureSeaCreatureCell(seaCreatureData: ownedDashboardViewModel.seaCreaturesData)
        case 2: dashboardCell.configureBugCell(bugData: ownedDashboardViewModel.bugData)
        case 3: dashboardCell.configureFossilCell(fossilData: ownedDashboardViewModel.fossilData)
        default:
            break
        }
        return dashboardCell
    }
}

extension OwnedDashboardViewController: UITableViewDelegate {
    
}
