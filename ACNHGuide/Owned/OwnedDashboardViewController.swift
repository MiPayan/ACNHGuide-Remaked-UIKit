//
//  OwnedDashboardViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class OwnedDashboardViewController: UIViewController {
    
    private var fishesDashboardView: UIView = {
        let view = DashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()
    
    private var seaCreaturesDashboardView: UIView = {
        let view = DashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private var bugsDashboardView: UIView = {
        let view = DashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private var fossilsDashboardView: UIView = {
        let view = DashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fishesDashboardView)
        view.addSubview(seaCreaturesDashboardView)
        view.addSubview(bugsDashboardView)
        view.addSubview(fossilsDashboardView)
        NSLayoutConstraint.activate([
            fishesDashboardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            fishesDashboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fishesDashboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            seaCreaturesDashboardView.topAnchor.constraint(equalTo: fishesDashboardView.bottomAnchor, constant: 16),
            seaCreaturesDashboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            seaCreaturesDashboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bugsDashboardView.topAnchor.constraint(equalTo: seaCreaturesDashboardView.bottomAnchor, constant: 16),
            bugsDashboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bugsDashboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            fossilsDashboardView.topAnchor.constraint(equalTo: bugsDashboardView.bottomAnchor, constant: 16),
            fossilsDashboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fossilsDashboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fossilsDashboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
}
