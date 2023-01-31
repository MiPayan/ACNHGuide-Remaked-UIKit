//
//  BugDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class BugDetailsViewController: UIViewController {
    
    var bugData: BugData?
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bugData,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? BugDetailsTableViewCell else { return UITableViewCell() }
        let bugDetailsViewModel = BugDetailsViewModel(bugData: bugData)
        detailsCell.configureDetailsCell(bugDetailsViewModel: bugDetailsViewModel)
        return detailsCell
    }
}
