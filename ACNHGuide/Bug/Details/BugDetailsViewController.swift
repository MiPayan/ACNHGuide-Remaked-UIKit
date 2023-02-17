//
//  BugDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class BugDetailsViewController: UIViewController {
    
    var bugDetailsViewModel: BugDetailsViewModel?
    private lazy var bugTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BugDetailsTableViewCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
    }
    
    private func addConstraints() {
        view.addSubview(bugTableView)
        NSLayoutConstraint.activate([
            bugTableView.topAnchor.constraint(equalTo: view.topAnchor),
            bugTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bugTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bugTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BugDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let bugDetailsViewModel else { return 0 }
        return bugDetailsViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bugDetailsViewModel,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? BugDetailsTableViewCell else { return UITableViewCell() }
        let bugDetailsTableViewCellViewModel = BugDetailsTableViewCellViewModel(bugData: bugDetailsViewModel.bugData)
        detailsCell.configureDetailsCell(with: bugDetailsTableViewCellViewModel)
        return detailsCell
    }
}
