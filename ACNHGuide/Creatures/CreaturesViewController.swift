//
//  CreaturesViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/06/2023.
//

import UIKit
import SwiftUI


final class CreaturesViewController: UIViewController {
    
    private var creaturesViewModel = CreaturesViewModel()
    private lazy var containerTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CreaturesTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "creaturesHeader")
        tableView.register(FishesTableViewCell.self, forCellReuseIdentifier: "allFishes")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorSand")
        addSubviews()
        setUpUpdateDataHandler()
        creaturesViewModel.getCreatures()
    }
}

private extension CreaturesViewController {
    func setUpUpdateDataHandler() {
        creaturesViewModel.successHandler = {
            self.containerTableView.reloadData()
        }
    }
    
    func addSubviews() {
        view.addSubview(containerTableView)
        NSLayoutConstraint.activate([
            containerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CreaturesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        creaturesViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        creaturesViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allFishes", for: indexPath) as? FishesTableViewCell else { return UITableViewCell() }
        let fishesTableViewCellViewModel = FishesTableViewCellViewModel(fishesData: creaturesViewModel.fishesData)
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.configureCell(with: fishesTableViewCellViewModel)
        cell.configureSubTitle(with: fishesTableViewCellViewModel.makeSubTitle(with: "Fishes"))
        return cell
    }
}

extension CreaturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "creaturesHeader") as? CreaturesTableViewHeaderView
        headerView?.configureHeaderLabel(with: creaturesViewModel.headerSection)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 70 : 0
    }
}
