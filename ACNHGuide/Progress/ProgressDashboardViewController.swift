//
//  ProgressDashboardViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class ProgressDashboardViewController: UIViewController {
    
    private let progressDashboardViewModel = ProgressDashboardViewModel()
    private lazy var dashboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "DashboardCell")
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpUpdateDataHandler()
        progressDashboardViewModel.getDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dashboardTableView.reloadData()
    }
    
    func setUpUpdateDataHandler() {
        progressDashboardViewModel.successHandler = {
            self.dashboardTableView.reloadData()
        }
    }
}

private extension ProgressDashboardViewController {
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

extension ProgressDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressDashboardViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dashboardCell = tableView.dequeueReusableCell(
            withIdentifier: "DashboardCell",
            for: indexPath
        ) as? DashboardTableViewCell else { return UITableViewCell() }
        let fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(fishesData: progressDashboardViewModel.fishData)
        let seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(seaCreaturesData: progressDashboardViewModel.seaCreaturesData)
        let bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(bugsData: progressDashboardViewModel.bugData)
        let fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(fossilsData: progressDashboardViewModel.fossilData)
        switch indexPath.row {
        case 0: dashboardCell.configureFishCell(with: fishDashboardTableViewCellViewModel)
        case 1: dashboardCell.configureSeaCreatureCell(with: seaCreatureDashboardTableViewCellViewModel)
        case 2: dashboardCell.configureBugCell(with: bugDashboardTableViewCellViewModel)
        case 3: dashboardCell.configureFossilCell(with: fossilDashboardTableViewCellViewModel)
        default:
            break
        }
        return dashboardCell
    }
}
