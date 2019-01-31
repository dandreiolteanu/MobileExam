//
//  ActionViewController.swift
//  Exam
//
//  Created by Olteanu Andrei on 30/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import Reusable
import IHProgressHUD
import RestBird

class ActionViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!

    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Buy Products"
        nameLabel.text = product.name
    }

    @IBAction func actionButtonTouched(_ sender: UIButton) {
        guard
            let id = product.id,
            let quantity = Int(quantityTextField.text ?? "")
        else {
            showAlert(title: "Data must be valid")
            return
        }

        IHProgressHUD.show()
        let actionRequest = ActionRequest(id: id, quantity: quantity)
        Server.shared.networkClient.execute(request: actionRequest) { (result: Result<Product>) in
            switch result {
            case .success(let product):
                log("Buy product success -> \(product)")
                IHProgressHUD.dismiss()
                self.proceedToNextStep(with: product, and: quantity)
            case .failure(let error):
                log("Buy product failure with: \(error.localizedDescription)")
                IHProgressHUD.dismiss()
                self.showAlert(title: "Can't buy product")
            }
        }
    }

    private func proceedToNextStep(with product: Product, and quanity: Int) {
        let viewController = DetailViewController.instantiate()
        viewController.product = product
        viewController.quantity = quanity
        navigationController?.pushViewController(viewController, animated: true)
    }
}
