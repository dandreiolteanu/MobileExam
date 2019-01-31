//
//  InMemoryViewController.swift
//  Exam
//
//  Created by Olteanu Andrei on 31/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import UIKit
import Reusable

class InMemoryViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        InMemory.shared.getAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "In Memory"

        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        tableView.register(cellType: ClientMainCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InMemoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InMemory.shared.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ClientMainCell.self)
        cell.configure(with: InMemory.shared.items[indexPath.row])
        return cell
    }
}

extension InMemoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
