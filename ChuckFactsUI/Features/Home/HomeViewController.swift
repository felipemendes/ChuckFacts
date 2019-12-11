//
//  HomeViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD

public class HomeViewController: UIViewController, ViewLayoutable {

    // MARK: - CONSTANTS

    private struct Constants {
        static let factReuseIdentifier = "FactCell"
    }

    // MARK: - PUBLIC API

    weak var delegate: HomeViewControllerDelegate?
    var placeholderView: PlaceholderView = PlaceholderView(placeholderType: .home)
    var alertView: JGProgressHUD = JGProgressHUD(style: .light)

    // MARK: - PROPERTIES

    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    private var factResponse: FactResponse?

    // MARK: - INITIALIZERS

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        constraintLayout()
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
        updateView(to: .empty, above: tableView)
        viewModel.viewDidLoad()
    }

    // MARK: - PUBLIC API

    public func reloadData(with keyword: String) {
        viewModel.retrieveSearchFact(from: keyword)
        updateView(to: .content, above: tableView)
        bindObservables()
    }

    // MARK: - BINDING

    private func bindObservables() {
        viewModel.factResponseObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.performBindind(for: response)
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
            tableView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - PRIVATE FUNCTIONS

    private func performBindind(for response: FactResponseType) {
        if let error = response.error {
            updateAlert(to: .error(message: error))
            return
        }

        if response.factResponse?.result.count == 0 {
            updateView(to: .empty, above: tableView)
            updateAlert(to: .dismiss)
            return
        }

        factResponse = response.factResponse
        tableView.reloadData()
        updateAlert(to: .dismiss)
    }

    private func configureSearchBarButton() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchView))
        navigationItem.rightBarButtonItem = searchItem
    }

    // MARK: - HANDLERS

    @objc func showSearchView() {
        updateAlert(to: .loading)
        delegate?.homeViewControllerDelegate(self, didTapSearch: nil)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factResponse?.result.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.factReuseIdentifier, for: indexPath)
            as? FactCell else {
                return UITableViewCell()
        }

        cell.viewModel = viewModel
        cell.delegate = self
        cell.setup(with: factResponse?.result[indexPath.row])

        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}

// MARK: - FactCellDelegate

extension HomeViewController: FactCellDelegate {
    public func didTapShare(message: String) {
        delegate?.homeViewControllerDelegate(self, didTapShare: message)
    }
}
