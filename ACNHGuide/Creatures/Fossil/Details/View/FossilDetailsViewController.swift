//
//  FossilDetailsViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FossilDetailsViewController: UIViewController {
    
    var fossilDetailsViewModel: FossilDetailsViewModel?
    weak var reloadDataDelegate: ReloadDataDelegate?
    private var fossilTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FossilTableViewCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "ColorSand")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        fossilTableView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reloadDataDelegate?.reloadData()
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

// MARK: - ErrorToastable

extension FossilDetailsViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - TableViewDataSource

extension FossilDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fossilDetailsViewModel else { return 0 }
        return fossilDetailsViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fossilDetailsViewModel,
              let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsCell",
                for: indexPath
              ) as? FossilTableViewCell else { return UITableViewCell() }
        let fossilDetailsTableViewCellViewModel = FossilDetailsTableViewCellViewModel(fossilData: fossilDetailsViewModel.fossilData)
        detailsCell.configureDetailsCell(with: fossilDetailsTableViewCellViewModel, view: self)
        return detailsCell
    }
}
