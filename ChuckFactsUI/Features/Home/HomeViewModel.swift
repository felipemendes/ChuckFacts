//
//  HomeViewModel.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import RxSwift
import Foundation

typealias FactResponseType = (factResponse: FactResponse?, error: String?)

public class HomeViewModel {

    // MARK: - CONSTANTS

    private struct Constants {
        static let maxFontSize: Int = 80
        static let defaultCategoryName: String = "UNCATEGORIZED"
    }

    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private let serviceManager: ServiceManager
    
    

    // MARK: - PUBLIC

    let factResponseObservable = PublishSubject<FactResponseType>()

    // MARK: - INITIALIZERS

    public init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }

    // MARK: - LIFE CYCLE

    public func viewDidLoad() {
        //retrieveSearchFact(from: "Bruce Lee")
    }

    // MARK: - PUBLIC API

    func retrieveCategoryName(for fact: Fact) -> String {
        guard let name = fact.categories.first else {
            return Constants.defaultCategoryName
        }
        return name?.uppercased() ?? Constants.defaultCategoryName
    }

    func retrievePreferredTypography(for value: String) -> Guideline.Typography {
        if value.count >= Constants.maxFontSize {
            return .subtitle(weight: .semibold)
        }
        return .title(weight: .semibold)
    }

    func retrieveSearchFact(from keyword: String) {
        serviceManager.getSearch(from: keyword) { response, error in
            self.handleFactResponse(response, error)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func handleFactResponse(_ factResponse: FactResponse?, _ error: String?) {
        factResponseObservable.onNext((factResponse, error))
    }
}
