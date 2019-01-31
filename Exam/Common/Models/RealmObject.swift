//
//  RealmObject.swift
//  Exam
//
//  Created by Olteanu Andrei on 31/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionString: String = ""
    @objc dynamic var quantity: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var status: String = ""
}
