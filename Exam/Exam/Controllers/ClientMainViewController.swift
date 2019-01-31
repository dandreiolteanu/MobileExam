//
//  ClientMainViewController.swift
//  Exam
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import RestBird
import Starscream
import IHProgressHUD

class ClientMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let socketService = SocketService<Product>()
    private var products: [Product] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
        getProducts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        listenToWebSocket()
        setupView()
    }

    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.register(cellType: ClientMainCell.self)
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func myProductsTouched(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(InMemoryViewController.instantiate(), animated: true)
    }

    private func listenToWebSocket() {
        socketService.didRecieveObject = { object in
            self.products.append(object)
            self.products = self.products.sorted(by: { return $0.price > $1.price })
            self.tableView.reloadData()
            self.showAlert(title: object.toString())
        }
    }

    private func getProducts() {
        IHProgressHUD.show()

        let getForClientRequest = GetForClientRequest()
        Server.shared.networkClient.execute(request: getForClientRequest) { (result: Result<[Product]>) in
            switch result {
            case .success(let products):
                log("Get For Client success")
                self.products = products.sorted(by: { return $0.price > $1.price })
                self.tableView.reloadData()
                IHProgressHUD.dismiss()
            case .failure(let error):
                log("Get For Client error -> \(error.localizedDescription)")
                IHProgressHUD.dismiss()

                self.showAlert(title: "Error", description: error.localizedDescription, actions: [
                    UIAlertAction(title: "Retry", style: .default, handler: { _ in
                        self.getProducts()
                    })])
            }
        }
    }
}

extension ClientMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ClientMainCell.self)
        cell.configure(with: products[indexPath.row])
        return cell
    }
}

extension ClientMainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = ActionViewController.instantiate()
        viewController.product = products[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
