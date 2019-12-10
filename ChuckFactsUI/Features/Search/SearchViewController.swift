//
//  SearchViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift

public class SearchViewController: UIViewController {

    // MARK: - ENUMS

    enum SearchType {
        case textInput
        case cloudTag
        case pastSearch
    }

    // MARK: - METRICS AND CONSTANTS

    private struct Constants {
        static let searchPlaceholder: String = "Enter your search term"
        static let minKeywordMinLength: Int = 2
    }

    private struct Metrics {
        static let searchFieldLeading: CGFloat = 8
        static let searchFieldTrailing: CGFloat = -8
        static let searchFieldTop: CGFloat = 30
        static let searchFieldHeight: CGFloat = 40

        static let borderHeight: CGFloat = 2

        static let cloudTagViewLeading: CGFloat = 8
        static let cloudTagViewTrailing: CGFloat = -8
        static let cloudTagViewTop: CGFloat = 8
        static let cloudTagViewHeight: CGFloat = 160

        static let pastSearchesViewLeading: CGFloat = 8
        static let pastSearchesViewTrailing: CGFloat = -8
        static let pastSearchesViewTop: CGFloat = 8
        static let pastSearchesViewBottom: CGFloat = -8
    }

    // MARK: - PUBLIC API

    weak var delegate: SearchViewControllerDelegate?

    // MARK: - PROPERTIES

    private let viewModel: SearchViewModel
    private let cloudTagViewModel: CloudTagViewModel
    private let pastSearchesViewModel: PastSearchesViewModel

    // MARK: - INITIALIZERS

    public init(viewModel: SearchViewModel,
                cloudTagViewModel: CloudTagViewModel,
                pastSearchesViewModel: PastSearchesViewModel) {
        self.viewModel = viewModel
        self.cloudTagViewModel = cloudTagViewModel
        self.pastSearchesViewModel = pastSearchesViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.searchPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.delegate = self
        return textField
    }()

    private lazy var border: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .gray
        return border
    }()

    private lazy var cloudTagView: CloudTagView = {
        let cloudTagView = CloudTagView(viewModel: cloudTagViewModel)
        cloudTagView.translatesAutoresizingMaskIntoConstraints = false
        cloudTagView.delegate = self
        return cloudTagView
    }()

    private lazy var pastSearchesView: PastSearchesView = {
        let pastSearchesView = PastSearchesView(viewModel: pastSearchesViewModel)
        pastSearchesView.translatesAutoresizingMaskIntoConstraints = false
        pastSearchesView.delegate = self
        return pastSearchesView
    }()

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadComponents()
    }

    // MARK: - PRIVATE SETUP

    private func reloadComponents() {
        cloudTagView.reloadView()
        pastSearchesView.reloadView()
    }

    private func perform(search keyword: String, from: SearchType) {
        switch from {
        case .pastSearch, .cloudTag: ()
        case .textInput:
            if viewModel.check(minLength: Constants.minKeywordMinLength, for: keyword) {
                return
            }
            viewModel.addSearch(keyword: keyword)

            searchTextField.resignFirstResponder()
            searchTextField.text = nil
        }
        delegate?.searchViewControllerDelegate(self, didTapSearch: keyword)
    }

    private func layoutView() {
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(border)
        view.addSubview(cloudTagView)
        view.addSubview(pastSearchesView)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor,
                                                 constant: Metrics.searchFieldTop),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: Metrics.searchFieldLeading),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: Metrics.searchFieldTrailing),
            searchTextField.heightAnchor.constraint(equalToConstant: Metrics.searchFieldHeight),

            border.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: Metrics.borderHeight),

            cloudTagView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,
                                              constant: Metrics.cloudTagViewTop),
            cloudTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Metrics.cloudTagViewLeading),
            cloudTagView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Metrics.cloudTagViewTrailing),
            cloudTagView.heightAnchor.constraint(equalToConstant: Metrics.cloudTagViewHeight),

            pastSearchesView.topAnchor.constraint(equalTo: cloudTagView.bottomAnchor,
                                              constant: Metrics.pastSearchesViewTop),
            pastSearchesView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Metrics.pastSearchesViewLeading),
            pastSearchesView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Metrics.pastSearchesViewTrailing),
            pastSearchesView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: Metrics.pastSearchesViewBottom)
        ])
    }
}

// MARK: - CloudTagViewDelegate

extension SearchViewController: CloudTagViewDelegate {
    func cloudTagView(_ cloudTagView: CloudTagView, didTappedIn keyword: String) {
        perform(search: keyword, from: .cloudTag)
    }
}

// MARK: - PastSearchesViewDelegate

extension SearchViewController: PastSearchesViewDelegate {
    func pastSearchesView(_ pastSearchesView: PastSearchesView, didTappedIn keyword: String) {
        perform(search: keyword, from: .pastSearch)
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        perform(search: text, from: .textInput)
        return true
    }
}
