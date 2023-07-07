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
        tableView.register(DashboardTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorSand")
        addSubviews()
        bindViewModel()
        progressDashboardViewModel.loadCreatures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressDashboardTableView.reloadData()
    }
    
    func bindViewModel() {
        progressDashboardViewModel.failureHandler
            .sink { [weak self] _ in
                guard let self else { return }
                errorView.isHidden = false
            }
            .store(in: &progressDashboardViewModel.cancellables)
        
        progressDashboardViewModel.reloadData
            .sink { [weak self] in
                guard let self else { return }
                self.progressDashboardTableView.reloadData()
            }
            .store(in: &progressDashboardViewModel.cancellables)
    }
}

private extension ProgressDashboardViewController {
    func addSubviews() {
        view.addSubview(progressDashboardTableView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            progressDashboardTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            let fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(fishesData: progressDashboardViewModel.fishes)
            dashboardCell.configureFishCell(with: fishDashboardTableViewCellViewModel)
        case 1:
            let seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(seaCreaturesData: progressDashboardViewModel.seaCreatures)
            dashboardCell.configureSeaCreatureCell(with: seaCreatureDashboardTableViewCellViewModel)
        case 2:
            let bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(bugsData: progressDashboardViewModel.bugs)
            dashboardCell.configureBugCell(with: bugDashboardTableViewCellViewModel)
        case 3:
            let fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(fossilsData: progressDashboardViewModel.fossils)
            dashboardCell.configureFossilCell(with: fossilDashboardTableViewCellViewModel)
        default:
            break
        }
        return dashboardCell
    }
}

extension ProgressDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? DashboardTableViewHeaderFooterView else { return UIView() }
        return headerView
    }
}
