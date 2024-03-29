//
//  SeaCreatureDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class SeaCreatureDetailsViewController: UIViewController {
    
    var seaCreaturesDetailsViewModel: SeaCreaturesDetailsViewModel?
    weak var reloadDataDelegate: ReloadDataDelegate?
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reloadDataDelegate?.reloadData()
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

// MARK: - ErrorToastable

extension SeaCreatureDetailsViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - TableViewDataSource

extension SeaCreatureDetailsViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let seaCreaturesDetailsViewModel else { return 0 }
        return seaCreaturesDetailsViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let seaCreaturesDetailsViewModel,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? SeaCreatureDetailsTableViewCell else { return UITableViewCell() }
        let seaCreaturesDetailsTableViewCellViewModel = SeaCreaturesDetailsTableViewCellViewModel(
            seaCreatureData: seaCreaturesDetailsViewModel.seaCreatureData
        )
        detailsCell.configureDetailsCell(with: seaCreaturesDetailsTableViewCellViewModel, view: self)
        return detailsCell
    }
}
