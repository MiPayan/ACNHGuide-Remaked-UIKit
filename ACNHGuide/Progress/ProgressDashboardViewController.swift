//
//  ProgressDashboardViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class ProgressDashboardViewController: UIViewController {
    
    private let progressDashboardViewModel = ProgressDashboardViewModel()
    private lazy var progressDashboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "DashboardCell")
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpUpdateDataHandler()
        progressDashboardViewModel.getDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressDashboardTableView.reloadData()
    }
    
    func setUpUpdateDataHandler() {
        progressDashboardViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        progressDashboardViewModel.successHandler = {
            self.errorView.isHidden = true
            self.progressDashboardTableView.reloadData()
        }
    }
}

private extension ProgressDashboardViewController {
    func addSubviews() {
        view.addSubview(progressDashboardTableView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            progressDashboardTableView.topAnchor.constraint(equalTo: view.topAnchor),
            progressDashboardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressDashboardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressDashboardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ReloadDataDelegate

extension ProgressDashboardViewController: ReloadDataDelegate {
    func reloadData() {
        progressDashboardTableView.reloadData()
    }
}

// MARK: - TableViewDataSource

extension ProgressDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressDashboardViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dashboardCell = tableView.dequeueReusableCell(
            withIdentifier: "DashboardCell",
            for: indexPath
        ) as? DashboardTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(
                fishesData: progressDashboardViewModel.fishesData
            )
            dashboardCell.configureFishCell(with: fishDashboardTableViewCellViewModel)
        case 1:
            let seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(
                seaCreaturesData: progressDashboardViewModel.seaCreaturesData
            )
            dashboardCell.configureSeaCreatureCell(with: seaCreatureDashboardTableViewCellViewModel)
        case 2:
            let bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(
                bugsData: progressDashboardViewModel.bugsData
            )
            dashboardCell.configureBugCell(with: bugDashboardTableViewCellViewModel)
        case 3:
            let fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(
                fossilsData: progressDashboardViewModel.fossilsData
            )
            dashboardCell.configureFossilCell(with: fossilDashboardTableViewCellViewModel)
        default:
            break
        }
        return dashboardCell
    }
}
