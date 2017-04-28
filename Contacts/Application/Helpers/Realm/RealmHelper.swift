//
//  RealmHelper.swift
//  Contacts
//
//  Created by Ari Munandar on 4/25/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class RealmHelper {

    class var sharedInstance: RealmHelper {
        struct Singleton {
            static let instance: RealmHelper = RealmHelper()
        }
        return Singleton.instance
    }

    let realm = try! Realm()

    func create<T>(object: T) {
        try! realm.write {
            self.realm.add(object as! Object, update: true)
        }
    }

    func update<T: Object>(object: T.Type, value: Any) {
        try! realm.write {
            self.realm.create(object, value: value, update: true)
        }
    }

    func findAll<T: Object>(object: T.Type) -> Results<T> {
        return self.realm.objects(object)
    }

    func filter<T: Object>(object: T.Type, predicate: String) -> Results<T> {
        return self.realm.objects(object).filter(predicate)
    }

    func detail<T: Object>(object: T.Type, predicate: String) -> T? {
        return self.realm.objects(object).filter(predicate).first
    }

}
