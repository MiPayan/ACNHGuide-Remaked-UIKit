//
//  ProgressDashboardViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class ProgressDashboardViewController: UIViewController {
    private let fishProgressDashboardViewModel = FishProgressDashboardViewModel()
    private let seaCreatureProgressDashboardViewModel = SeaCreatureProgressDashboardViewModel()
    private let bugProgressDashboardViewModel = BugProgressDashboardViewModel()
    private let fossilProgressDashboardViewModel = FossilProgressDashboardViewModel()
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
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpUpdateDataHandler()
        getDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dashboardTableView.reloadData()
    }
    
    func setUpFailureHandler() {

    }
    
    func setUpUpdateDataHandler() {
        fishProgressDashboardViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        seaCreatureProgressDashboardViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        bugProgressDashboardViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        fossilProgressDashboardViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        fishProgressDashboardViewModel.successHandler = {
            self.errorView.isHidden = true
            self.dashboardTableView.reloadData()
        }
        seaCreatureProgressDashboardViewModel.successHandler = {
            self.errorView.isHidden = true
            self.dashboardTableView.reloadData()
        }
        bugProgressDashboardViewModel.successHandler = {
            self.errorView.isHidden = true
            self.dashboardTableView.reloadData()
        }
        fossilProgressDashboardViewModel.successHandler = {
            self.errorView.isHidden = true
            self.dashboardTableView.reloadData()
        }
    }
}

private extension ProgressDashboardViewController {
    func getDatas() {
        fishProgressDashboardViewModel.getFishesData()
        seaCreatureProgressDashboardViewModel.getSeaCreaturesData()
        bugProgressDashboardViewModel.getBugsData()
        fossilProgressDashboardViewModel.getFossilsData()
    }
    
    func addSubviews() {
        view.addSubview(dashboardTableView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            dashboardTableView.topAnchor.constraint(equalTo: view.topAnchor),
            dashboardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dashboardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dashboardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProgressDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dashboardCell = tableView.dequeueReusableCell(
            withIdentifier: "DashboardCell",
            for: indexPath
        ) as? DashboardTableViewCell else { return UITableViewCell() }
        let fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(
            fishesData: fishProgressDashboardViewModel.fishesData
        )
        switch indexPath.row {
        case 0:

            dashboardCell.configureFishCell(with: fishDashboardTableViewCellViewModel)
        case 1:
            let seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(
                seaCreaturesData: seaCreatureProgressDashboardViewModel.seaCreaturesData
            )
            dashboardCell.configureSeaCreatureCell(with: seaCreatureDashboardTableViewCellViewModel)
        case 2:
            let bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(
                bugsData: bugProgressDashboardViewModel.bugsData
            )
            dashboardCell.configureBugCell(with: bugDashboardTableViewCellViewModel)
        case 3:
            let fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(
                fossilsData: fossilProgressDashboardViewModel.fossilsData
            )
            dashboardCell.configureFossilCell(with: fossilDashboardTableViewCellViewModel)
        default:
            break
        }
        return dashboardCell
    }
}
