//
//  DetailViewController.swift
//  Exam
//
//  Created by Olteanu Andrei on 30/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import Reusable

class DetailViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    var product: Product!
    var quantity: Int!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        idLabel.text = "Id: \(product.id ?? -1)"
        nameLabel.text = "Name: \(product.name)"
        descriptionLabel.text = "Description: \(product.description)"
        quantityLabel.text = "Qty \(product.quantity)"
        priceLabel.text = "\(product.price)$"
        statusLabel.text = "Status \(product.status)"

        InMemory.shared.buyProduct(product: product, quantity: quantity)
    }
    
    @IBAction func doneButtonTouched(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
