//
//  ContactAPI.swift
//  Contacts
//
//  Created by Ari Munandar on 4/23/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RealmSwift
import RxSwift

/**
* Setup ContactList Dependencies
*/
class ContactAPI {

    // MARK: Singleton
    class var sharedInstance: ContactAPI {
        struct Singleton {
            static let instance: ContactAPI = ContactAPI()
        }
        return Singleton.instance
    }

}
