//
//  HomeViewModel.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import RxSwift
import Foundation

public class HomeViewModel {

    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private let serviceManager: ServiceManager

    let factResponseObservable = PublishSubject<FactResponse>()

    // MARK: - INITIALIZERS

    public init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }

    // MARK: - LIFE CYCLE

    public func viewDidLoad() {
//        retrieveSearchFact(from: "Bruce Lee")
    }

    // MARK: - PUBLIC

    func retrieveSearchFact(from keyword: String) {
        serviceManager.getSearch(from: keyword) { response, error in
            self.handleFactResponse(response, error)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func handleFactResponse(_ factResponse: FactResponse?, _ error: String?) {
        guard let factResponse = factResponse else { return }
        factResponseObservable.onNext(factResponse)
    }
}
