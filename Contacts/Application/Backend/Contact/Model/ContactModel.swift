//
//  ContactModel.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import RealmSwift

/**
* Setup ContactModel
*/
struct ContactModel {

    struct Create {

        struct Request {
            var firstName: String?
            var lastName: String?
            var email: String?
            var phoneNumber: String?
            var favorite: Bool? = false
        }

        struct Response {
            var contact: ContactListEntity?
        }

    }

    struct Update {

        struct Request {
            var id: Int? = 0
            var firstName: String?
            var lastName: String?
            var email: String?
            var phoneNumber: String?
        }

        struct Response {
            var contact: ContactListEntity?
        }

    }

    struct List {

        struct Request {
            var isLoadData: Bool = false
        }

        struct Response {
            var contacts: [(key: String, value: [ContactListEntity])]?
        }

    }

    struct Detail {

        struct Request {
            var id: Int? = 0
        }

        struct Response {
            var contact: ContactListEntity?
        }

    }

    struct Delete {

        struct Request {
            var id: Int? = 0
        }

        struct Response {
            var contact: ContactListEntity?
        }

    }

    struct Favorite {

        struct Request {
            var id: Int? = 0
            var isFavorite: Bool? = false
        }

        struct Response {
            var contact: ContactListEntity?
        }

    }

}
