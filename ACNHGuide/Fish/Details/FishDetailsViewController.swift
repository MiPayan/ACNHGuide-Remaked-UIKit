//
//  FishDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FishDetailsViewController: UIViewController {
    
    var fishDetailsViewModel: FishDetailsViewModel?
    weak var reloadDataDelegate: ReloadDataDelegate?
    private lazy var fishTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FishDetailsTableViewCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reloadDataDelegate?.reloadCollectionView()
    }
    
    private func addConstraints() {
        view.addSubview(fishTableView)
        NSLayoutConstraint.activate([
            fishTableView.topAnchor.constraint(equalTo: view.topAnchor),
            fishTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fishTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fishTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FishDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fishDetailsViewModel else { return 0 }
        return fishDetailsViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fishDetailsViewModel,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? FishDetailsTableViewCell else { return UITableViewCell() }
        let fishDetailsTableViewCellViewModel = FishDetailsTableViewCellViewModel(fishData: fishDetailsViewModel.fishData)
        detailsCell.configureDetailsCell(with: fishDetailsTableViewCellViewModel)
        return detailsCell
    }
}
