//
//  ViewController.swift
//  Exam-Clerk
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import RestBird
import IHProgressHUD

class ClerkMainViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var products: [Product] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        IHProgressHUD.show()
        let getAllRequest = GetAllRequest()
        Server.shared.networkClient.execute(request: getAllRequest) { (result: Result<[Product]>) in
            switch result {
            case .success(let products):
                log("Get All Products: Success with number of products -> \(products.count)")

                self.products = products.sorted(by: { return $0.quantity > $1.quantity })
                self.tableView.reloadData()
                IHProgressHUD.dismiss()
            case .failure(let error):
                log("Get All Products: Error with -> \(error)")

                IHProgressHUD.dismiss()
                self.showAlert(title: "Error  \(error.localizedDescription)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: ClerkMainCell.self)
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func deleteItem(at indexPath: IndexPath) {
        guard let id = products[indexPath.row].id else { return }

        IHProgressHUD.show()
        let deleteRequest = DeleteRequest(id: id)
        Server.shared.networkClient.execute(request: deleteRequest) { (result: Result<Product>) in
            switch result {
            case .success:
                log("Delete Product: Success")

                self.products.remove(at: indexPath.row)
                self.tableView.reloadData()
                IHProgressHUD.dismiss()
            case .failure(let error):
                log("Delete Product: Error with -> \(error)")

                IHProgressHUD.dismiss()
                self.showAlert(title: "Error \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ClerkMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ClerkMainCell.self)
        cell.configure(with: products[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(at: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate

extension ClerkMainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
