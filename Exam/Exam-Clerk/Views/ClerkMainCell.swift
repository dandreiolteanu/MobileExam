//
//  ClerkMainCell.swift
//  Exam-Clerk
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import Reusable

class ClerkMainCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    func configure(with product: Product) {
        nameLabel.text = product.name
        quantityLabel.text = "Qty \(product.quantity)"
        priceLabel.text = "\(product.price)$"
        statusLabel.text = product.status.rawValue.capitalized
    }
}
