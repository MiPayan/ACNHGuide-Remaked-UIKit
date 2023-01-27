//
//  SeaCreatureDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class SeaCreatureDetailsViewController: UIViewController {
    
    var seaCretureData: SeaCreatureData?
    private var seaCreatureTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SeaCreatureDetailsTableViewCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "ColorSand")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(seaCreatureTableView)
        addConstraints()
        seaCreatureTableView.dataSource = self
    }
}

private extension SeaCreatureDetailsViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
            seaCreatureTableView.topAnchor.constraint(equalTo: view.topAnchor),
            seaCreatureTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seaCreatureTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seaCreatureTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SeaCreatureDetailsViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let seaCreature = seaCretureData,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? SeaCreatureDetailsTableViewCell else { return UITableViewCell() }
        detailsCell.configureDetailsCell(seaCreaturesData: seaCreature)
        return detailsCell
    }
}
