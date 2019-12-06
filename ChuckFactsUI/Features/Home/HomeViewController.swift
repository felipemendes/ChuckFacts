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

    private struct Constants {
        static let factReuseIdentifier = "FactCell"
    }

    // MARK: - PROPERTIES

    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    private var factResponse: FactResponse?

    // MARK: - INITIALIZERS

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        layoutView()
        setupUI()
        constraintUI()
        bindObservables()
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
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FactCell.self, forCellReuseIdentifier: Constants.factReuseIdentifier)
        return tableView
    }()

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    // MARK: - BINDING

    private func bindObservables() {
        viewModel.factResponseObservable.subscribe(onNext: { factResponse in
            self.factResponse = factResponse
        }).disposed(by: disposeBag)
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        navigationItem.title = "Chuck Facts"
        view.backgroundColor = .white
        configureSearchBarButton()
    }

    private func setupUI() {
        view.addSubview(tableView)
    }

    private func constraintUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureSearchBarButton() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem = searchItem
    }

    // MARK: - HANDLERS

    @objc func showSearchBar() {
        viewModel.retrieveSearchFact(from: "Brazil")
        tableView.reloadData()
    }
}

// MARK: - EXTENSIONS

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factResponse?.result.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.factReuseIdentifier, for: indexPath)
            as? FactCell else {
                return UITableViewCell()
        }

        cell.setup(with: factResponse?.result[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
