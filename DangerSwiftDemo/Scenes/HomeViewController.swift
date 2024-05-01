//
//  HomeViewController.swift
//  DangerSwiftDemo
//
//  Created by Krunal Patel on 01/05/24.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Views
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello World!"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to the demo of Danger Swift"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    // MARK: - Methods
    private func setupViews() {
        view.backgroundColor = .background

        // Welcome Label
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Subtitle Label
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 18)
        ])
    }
}
