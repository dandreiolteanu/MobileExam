//
//  Extensions.swift
//  Exam-Clerk
//
//  Created by Olteanu Andrei on 28/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit

func log(_ message: String, function: String = #function, line: Int = #line, column: Int = #column) {
    print("\n--> \(message)\nFunction: \(function)\nLine: \(line) Column: \(column)\n")
}

extension UIViewController {

    func showAlert(title: String, description: String? = nil, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)

        var alertActions = [UIAlertAction]()
        if let actions = actions {
            alertActions += actions
        }

        alertActions.append(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        alertActions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
}
