//
//  InMemory.swift
//  Exam
//
//  Created by Olteanu Andrei on 31/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import Foundation
import RealmSwift

class InMemory {

    static let shared = InMemory()

    var items: [Product] = []

    private let realm = try! Realm()

    private init() { }

    func buyProduct(product: Product, quantity: Int) {
        guard let id = product.id else { return }
        let objects = realm.objects(RealmObject.self).filter("id = \(id)")

        if objects.isEmpty {
            let realmObject = RealmObject()
            realmObject.id = id
            realmObject.name = product.name
            realmObject.descriptionString = product.description
            realmObject.price = product.price
            realmObject.quantity = quantity
            realmObject.status = product.status.rawValue

            try! realm.write {
                realm.add(realmObject)
            }
        } else {
            let realmObject = objects.first
            guard let obj = realmObject else { return }
            try! realm.write {
                obj.quantity += quantity
            }
        }
    }

    func getAll() {
        let objects = realm.objects(RealmObject.self)
        items = objects.map { Product(realmObject: $0) }
    }
}
