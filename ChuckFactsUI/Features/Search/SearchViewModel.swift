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

    // MARK: - INITIALIZERS

    public init(searchDataAccessProvider: SearchDataAccessProvider) {
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

    public func check(minLength length: Int, for keyword: String) -> Bool {
        return keyword.count < length ? true : false
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
