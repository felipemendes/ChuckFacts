//
//  HomeViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift

public class HomeViewController: UIViewController {

    // MARK: - CONSTANTS

    private struct Metrics {
        static let margin: CGFloat = 8
    }

    // MARK: - PROPERTIES

    private let disposeBag = DisposeBag()
    private let factReuseIdentifier = "FactCell"
    private let facts = ["Fact 1", "Fact 2", "Fact 3", "Fact 4", "Fact 5", "Fact 6"]

    // MARK: - PUBLIC API

    // MARK: - INITIALIZERS

    public init() {
        super.init(nibName: nil, bundle: nil)
        layoutView()
        setupUI()
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FactCell.self, forCellReuseIdentifier: factReuseIdentifier)
        return tableView
    }()

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        navigationItem.title = "Chuck Facts"
        view.backgroundColor = .white
    }

    private func setupUI() {
        view.addSubview(tableView)
    }

    private func constraintUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.margin),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.margin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.margin),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - EXTENSIONS

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell", for: indexPath)
            as? FactCell else {
                return UITableViewCell()
        }

        cell.setup(with: facts[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
