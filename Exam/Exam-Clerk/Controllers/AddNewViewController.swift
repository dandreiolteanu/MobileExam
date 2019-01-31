//
//  AddNewViewController.swift
//  Exam-Clerk
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import RestBird
import IHProgressHUD

class AddNewViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!

    @IBAction func addButtonTouched(_ sender: UIButton) {
        guard
            let name = nameTextField.text,
            let description = descriptionTextField.text,
            let quantity = Int(quantityTextField.text ?? ""),
            let price = Int(priceTextField.text ?? "")
        else {
            showAlert(title: "Data must be valid")
            return
        }

        IHProgressHUD.show()

        let addNewRequest = AddNewRequest(name: name, description: description, quantity: quantity, price: price)
        Server.shared.networkClient.execute(request: addNewRequest) { (result: Result<Product>) in
            switch result {
            case .success(let product):
                log("Add new product: Succes with -> \(product)")
                IHProgressHUD.dismiss()
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                log("Add new product: Error with -> \(error)")
                IHProgressHUD.dismiss()

                self.showAlert(title: "Error \(error.localizedDescription)")
            }
        }
    }
}
