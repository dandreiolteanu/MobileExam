//
//  Server.swift
//  Exam
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import Foundation
import RestBird

class Server {
    static let shared = Server()

    private init() { }

    let networkClient = NetworkClient(configuration: APIConfiguration())
}

/// GET All
struct GetAllRequest: DataRequest {
    typealias ResponseType = [Product]

    var suffix: String? { return "/all" }
    var method: HTTPMethod { return .get }
    var parameters: RequestParameters? { return nil }
}

/// ADD NEW
struct AddNewRequest: DataRequest {
    typealias ResponseType = Product

    let name: String
    let description: String
    let quantity: Int
    let price: Int

    var suffix: String? { return "/product"}
    var method: HTTPMethod { return .post }
    var parameters: RequestParameters? { return [
        "name": name,
        "description": description,
        "quantity": quantity,
        "price": price ]}
}

struct VoidResponse: Codable { }

/// DELETE
struct DeleteRequest: DataRequest {
    typealias ResponseType = Product

    let id: Int

    var suffix: String? { return "/product/\(id)" }
    var method: HTTPMethod { return .delete }
    var parameters: RequestParameters? { return nil }
}

/// GET CLIENT
struct GetForClientRequest: DataRequest {
    typealias ResponseType = [Product]

    var suffix: String? { return "/products" }
    var method: HTTPMethod { return .get }
    var parameters: RequestParameters? { return nil }
}

/// ACTION REQUEST
struct ActionRequest: DataRequest {
    typealias ResponseType = Product

    let id: Int
    let quantity: Int

    var suffix: String? { return "/buyProduct" }
    var method: HTTPMethod { return .post }
    var parameters: RequestParameters? { return [
        "id": id,
        "quantity": quantity ]}
}
