//
//  SearchDataAccessProvider.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 02/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

// swiftlint:disable force_cast
public class SearchDataAccessProvider {

    // MARK: - CONSTANTS

    private let entityName = "Search"

    // MARK: - PRIVATE PROPERTIES

    private var searchFromCoreData = Variable<[Search]>([])
    private var managedObjectContext: NSManagedObjectContext

    // MARK: - INITIALIZER

    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        searchFromCoreData.value = [Search]()
        managedObjectContext = delegate.persistentContainer.viewContext
        searchFromCoreData.value = retrieveData()
    }

    // MARK: - PRIVATE SETUP

    public func retrieveObservableData() -> Observable<[Search]> {
        searchFromCoreData.value = retrieveData()
        return searchFromCoreData.asObservable()
    }

    public func add(_ keyword: String) {
        if checkExistence(for: keyword) {
            print("Data already added")
            return
        }

        let newSearch = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                            into: managedObjectContext) as! Search
        newSearch.keyword = keyword

        do {
            try managedObjectContext.save()
            searchFromCoreData.value = retrieveData()
        } catch {
            fatalError("Error on add data: \(#function) on \(#line)")
        }
    }

    // MARK: - PRIVATE SETUP

    private func checkExistence(for keyword: String) -> Bool {
        let currentData = retrieveData()
        return currentData.filter({ $0.keyword == keyword}).count > 0
    }

    private func retrieveData() -> [Search] {
        let searchRequest = Search.searchRequest()
        searchRequest.returnsObjectsAsFaults = false

        do {
            return try managedObjectContext.fetch(searchRequest)
        } catch {
            print("No Search Data retrieved")
            return []
        }
    }
}
