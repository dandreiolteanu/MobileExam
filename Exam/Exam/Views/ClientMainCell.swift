//
//  ClientMainCell.swift
//  Exam
//
//  Created by Olteanu Andrei on 30/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import Reusable

class ClientMainCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func configure(with product: Product) {
        self.nameLabel.text = product.name
        self.quantityLabel.text = "Qty \(product.quantity)"
        self.priceLabel.text = "\(product.price)$"
    }
}
