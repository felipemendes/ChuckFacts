//
//  CloudTagViewModel.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation
import RxSwift

public class CloudTagViewModel {

    // MARK: - PRIVATE PROPERTIES

    private var disposeBag = DisposeBag()
    private let serviceManager: ServiceManager

    // MARK: - PUBLIC API

    public let categoryObservable = PublishSubject<[String]>()

    // MARK: - INITIALIZERS

    public init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }

    // MARK: - PUBLIC FUNCTIONS

    public func retrieveCategories(by amount: Int = 8) {
        serviceManager.getCategories { response, error in
            self.handleCategoryResponse(response, error)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func handleCategoryResponse(_ categoryResponse: [String]?, _ error: String?) {
        guard let categoryResponse = categoryResponse else { return }
        categoryObservable.onNext(categoryResponse)
    }
}
