//
//  DataProvider.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 09.06.2023.
//

import Foundation
import CoreData

struct CollectionStoreUpdate {
    let insertedIndexes: IndexSet
    let deletedIndexes: IndexSet
}

protocol DataProviderDelegate: AnyObject {
    func didUpdate(_ update: CollectionStoreUpdate)
}

final class DataProvider: NSObject {
    
    
    weak var delegate: DataProviderDelegate?
}
