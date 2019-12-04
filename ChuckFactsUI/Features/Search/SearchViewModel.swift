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
    private var searchDataAccessProvider = SearchDataAccessProvider()
    private var disposeBag = DisposeBag()

    // MARK: - INITIALIZERS

    public init() {
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
                self.searchCoreData.value = $0
            })
            .disposed(by: disposeBag)
    }
}
