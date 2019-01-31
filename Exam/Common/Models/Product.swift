//
//  Product.swift
//  Exam
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import Foundation

enum ProductStatus: String, Codable {
    case new
    case sold
    case popular
    case discounted
    case old
}

struct Product: Codable {
    var id: Int?
    var name: String
    var description: String
    var quantity: Int
    var price: Int
    var status: ProductStatus

    init(realmObject: RealmObject) {
        self.id = realmObject.id
        self.name = realmObject.name
        self.description = realmObject.description
        self.quantity = realmObject.quantity
        self.price = realmObject.price
        self.status = ProductStatus(rawValue: realmObject.status) ?? .sold
    }

    func toString() -> String {
        var string = ""
        string += "Id: \(id ?? 0)\n"
        string += "Name: \(name)\n"
        string += "Description: \(description)\n"
        string += "Quantity: \(quantity)\n"
        string += "Price: \(price)\n"
        string += "Status: \(status.rawValue)"
        return string
    }
}
