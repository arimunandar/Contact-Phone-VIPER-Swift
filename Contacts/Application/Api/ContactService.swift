//
//  ContactService.swift
//  Contacts
//
//  Created by Ari Munandar on 4/23/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit
import Moya

// MARK: - Provider setup
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it cant be serialized
    }
}

let ContactProvider = RxMoyaProvider<ContactService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum ContactService {
    case list
    case detail(id: Int)
    case create(firstName: String, lastName: String, email: String, phoneNumber: String, favorite: Bool)
    case update(id: Int, firstName: String, lastName: String, email: String, phoneNumber: String)
    case favorite(id: Int, favorite: Bool)
    case delete(id: Int)
}

// MARK: - TargetType Protocol Implementation
extension ContactService: TargetType {
    var baseURL: URL { return URL(string: "http://gojek-contacts-app.herokuapp.com")! }
    var path: String {
        switch self {
        case .list, .create(_, _, _, _, _):
            return "/contacts.json"
        case .detail(let id), .update(let id, _, _, _, _), .delete(let id), .favorite(let id, _):
            return "/contacts/\(id).json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .list, .detail:
            return .get
        case .create:
            return .post
        case .update, .favorite:
            return .put
        case .delete:
            return .delete
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .list, .detail, .delete:
            return nil
        case .create(let firstName, let lastName, let email, let phoneNumber, let favorite):
            return ["first_name": firstName, "last_name": lastName, "email": email, "phone_number": phoneNumber, "favorite": favorite]
        case .update(_, let firstName, let lastName, let email, let phoneNumber):
            return ["first_name": firstName, "last_name": lastName, "email": email, "phone_number": phoneNumber]
        case .favorite(_, let favorite):
            return ["favorite": favorite]
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .list, .detail, .delete:
            return URLEncoding.default // Send parameters in URL
        case .create, .update, .favorite:
            return JSONEncoding.default // Send parameters as JSON in request body
        }
    }

    var sampleData: Data {
        switch self {
        case .list:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        case .detail(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        case .create(let firstName, let lastName, let email, let phoneNumber, let favorite):
            return "{\"id\": 120, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\", \"email\": \"\(email)\", \"phone_number\": \"\(phoneNumber)\", \"favorite\": \"\(favorite)\"}".utf8Encoded
        case .update(let id, let firstName, let lastName, let phoneNumber, let email):
            return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\", , \"phone_number\": \"\(phoneNumber)\", \"email\": \"\(email)\"}".utf8Encoded
        case .delete(let id):
            return "{\"id\": \(id)}".utf8Encoded
        case .favorite(let id, let favorite):
            return "{\"id\": \(id)}, \"favorite\": \"\(favorite)\"".utf8Encoded
        }
    }

    var task: Task {
        switch self {
        case .list, .detail, .create, .update, .delete, .favorite:
            return .request
        }
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
