//
//  FossilDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FossilDetailsViewController: UIViewController {
    
    var fossilData: FossilData?
    private var fossilTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FossilTableViewCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "ColorSand")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        fossilTableView.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(fossilTableView)
        NSLayoutConstraint.activate([
            fossilTableView.topAnchor.constraint(equalTo: view.topAnchor),
            fossilTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fossilTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fossilTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FossilDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fossilData,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? FossilTableViewCell else { return UITableViewCell() }
        detailsCell.configureDetailsCell(fossilData: fossilData)
        return detailsCell
    }
}
