//
//  HomeViewModel.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 02/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

public class SearchViewModel {

    // MARK: - PRIVATE PROPERTIES

    private var searchCoreData = Variable<[Search]>([])
    private var disposeBag = DisposeBag()
    private var searchDataAccessProvider: SearchDataAccessProvider
    private let serviceManager: ServiceManager

    // MARK: - INITIALIZERS

    public init(serviceManager: ServiceManager,
                searchDataAccessProvider: SearchDataAccessProvider) {
        self.serviceManager = serviceManager
        self.searchDataAccessProvider = searchDataAccessProvider
        fetchSearchAndUpdateObservables()
    }

    // MARK: - PUBLIC FUNCTIONS

    public func retrieveSearches() -> Variable<[Search]> {
        return searchCoreData
    }

    public func addSearch(keyword: String) {
        searchDataAccessProvider.add(keyword)
    }

    // MARK: - PRIVATE FUNCTIONS

    private func fetchSearchAndUpdateObservables() {
        searchDataAccessProvider.retrieveObservableData()
            .map { $0 }
            .subscribe(onNext: {
                self.searchCoreData.value = $0.reversed()
            })
            .disposed(by: disposeBag)
    }
}
