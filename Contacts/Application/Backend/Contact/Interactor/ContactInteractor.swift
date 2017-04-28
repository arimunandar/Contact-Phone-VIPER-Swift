//
//  ContactInteractor.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import Moya
import ObjectMapper
import RealmSwift
import RxSwift

/**
* Setup Contact Interactor with Contact Interactor Input Protocol
*/
class ContactInteractor: ContactInteractorInputProtocol {

    // MARK: - Setup Variables
    weak var interactorOutputCreate: ContactCreateInteractorOutputProtocol?
    weak var interactorOutputUpdate: ContactUpdateInteractorOutputProtocol?
    weak var interactorOutputList: ContactListInteractorOutputProtocol?
    weak var interactorOutputDetail: ContactDetailInteractorOutputProtocol?
    weak var interactorOutputDelete: ContactDeleteInteractorOutputProtocol?
    weak var interactorOutputFavorite: ContactFavoriteInteractorOutputProtocol?

    init() {
        // Do someting
    }

    /**
	Handle Create Process
	
	- parameter request: Create request model
	*/
    func processContactCreate(_ request: ContactModel.Create.Request) {
        guard let firstName = request.firstName else {
            return
        }

        guard let lastName = request.lastName else {
            return
        }

        guard let email = request.email else {
            return
        }

        guard let phoneNumber = request.phoneNumber else {
            return
        }

        guard let favorite = request.favorite else {
            return
        }

        DispatchQueue.main.async {
            ContactProvider.request(.create(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, favorite: favorite), completion: { result in

                let message = "Unable to fetch from Contacts"

                switch result {
                case let .success(response):
                    do {
                        let data = try response.mapJSON()
                        if let value = Mapper<ContactListEntity>().map(JSONObject: data) {
                            print(value)
                            RealmHelper.sharedInstance.create(object: value)
                            let response = ContactModel.Create.Response()
                            self.interactorOutputCreate?.presentSuccessContactCreate(response)
                        } else {
                            self.interactorOutputCreate?.presentErrorContactCreate(message)
                        }
                    } catch {
                        self.interactorOutputCreate?.presentErrorContactCreate(message)
                    }
                case let .failure(error):
                    self.interactorOutputCreate?.presentErrorContactCreate("\(error)")
                }
            })
        }

    }

    /**
    Handle Update Process

    - parameter request: Update request model
    */
    func processContactUpdate(_ request: ContactModel.Update.Request) {
        guard let id = request.id else {
            return
        }

        guard let firstName = request.firstName else {
            return
        }

        guard let lastName = request.lastName else {
            return
        }

        guard let email = request.email else {
            return
        }

        guard let phoneNumber = request.phoneNumber else {
            return
        }

        DispatchQueue.main.async {

            ContactProvider.request(.update(id: id, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber), completion: { (result) in

                let message = "Unable to fetch from Contacts"

                switch result {
                case let .success(response):
                    do {
                        let data = try response.mapJSON()
                        if let value = Mapper<ContactListEntity>().map(JSONObject: data) {
                            print(value)
                            RealmHelper.sharedInstance.update(object: ContactListEntity.self, value: value)
                            let response = ContactModel.Update.Response()
                            self.interactorOutputUpdate?.presentSuccessContactUpdate(response)
                        } else {
                            self.interactorOutputUpdate?.presentErrorContactUpdate(message)
                        }
                    } catch {
                        self.interactorOutputUpdate?.presentErrorContactUpdate(message)
                    }
                case let .failure(error):
                    self.interactorOutputUpdate?.presentErrorContactUpdate("\(error)")
                }
            })
        }
    }

    /**
    Handle List Process
	
    - parameter request: List request model
    */
    func processContactList(_ request: ContactModel.List.Request) {

        if request.isLoadData {
            DispatchQueue.main.async {
                ContactProvider.request(.list, completion: { result in

                    let message = "Unable to fetch from Contacts"

                    switch result {
                    case let .success(response):
                        do {
                            let data = try response.mapJSON()
                            if let result = Mapper<ContactListEntity>().mapArray(JSONArray: data as! [[String: Any]]) {
                                for i in result {
                                    let contact = ContactListEntity()
                                    contact.firstName = i.firstName != nil ? i.firstName : ""
                                    contact.lastName = i.lastName != nil ? i.lastName : ""
                                    contact.id = i.id != 0 ? i.id : 0
                                    contact.profilePic = i.profilePic != nil ? i.profilePic : ""
                                    contact.url = i.url != nil ? i.url : ""
                                    contact.favorite = i.favorite
                                    RealmHelper.sharedInstance.create(object: contact)
                                }
                                var response = ContactModel.List.Response()
                                let data = RealmHelper.sharedInstance.findAll(object: ContactListEntity.self)
                                response.contacts = self.handleParsingData(data: data)
                                self.interactorOutputList?.presentSuccessContactList(response)

                                CacheHelper.setCache(value: true, key: CacheKey.IS_SYNCRONIZE)
                            } else {
                                self.interactorOutputList?.presentErrorContactList(message)
                            }
                        } catch {
                            self.interactorOutputList?.presentErrorContactList(message)
                        }
                    case let .failure(error):
                        self.interactorOutputList?.presentErrorContactList("\(error)")
                    }
                })
            }
        } else if CacheHelper.getCacheBool(key: CacheKey.IS_SYNCRONIZE) {
            var response = ContactModel.List.Response()
            let data = RealmHelper.sharedInstance.findAll(object: ContactListEntity.self)

            let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map({ String($0) })
            var result = [String: [ContactListEntity]]()

            for letter in alphabet {
                result[letter] = []
                let matches = data.filter({ $0.firstName!.lowercased().hasPrefix(letter.lowercased()) })
                if !matches.isEmpty {
                    for x in matches {
                        result[letter]?.append(x)
                    }
                }
            }
            let value = result.sorted(by: { $0.0 < $1.0 })

            response.contacts = value
            self.interactorOutputList?.presentSuccessContactList(response)
        }

    }

    /**
    Handle Detail Process
	
    - parameter request: Detail request model
    */
    func processContactDetail(_ request: ContactModel.Detail.Request) {
        guard let id = request.id else {
            return
        }

        DispatchQueue.main.async {
            ContactProvider.request(.detail(id: id), completion: { (result) in

                let message = "Unable to fetch from Contacts"

                switch result {
                case let .success(response):
                    do {
                        let data = try response.mapJSON()
                        if let value = Mapper<ContactListEntity>().map(JSONObject: data) {
                            RealmHelper.sharedInstance.update(object: ContactListEntity.self, value: value)
                            var response = ContactModel.Detail.Response()
                            response.contact = RealmHelper.sharedInstance.detail(object: ContactListEntity.self, predicate: "id = \(id)")
                            self.interactorOutputDetail?.presentSuccessContactDetail(response)
                        } else {
                            self.interactorOutputDetail?.presentErrorContactDetail(message)
                        }
                    } catch {
                        self.interactorOutputDetail?.presentErrorContactDetail(message)
                    }
                case let .failure(error):
                    self.interactorOutputDetail?.presentErrorContactDetail("\(error)")
                }
            })
        }
    }

    /**
    Handle Delete Process
	
    - parameter request: Delete request model
    */
    func processContactDelete(_ request: ContactModel.Delete.Request) {
        self.interactorOutputDelete?.presentSuccessContactDelete(ContactModel.Delete.Response())
        self.interactorOutputDelete?.presentErrorContactDelete("Error")
    }

    /**
	Handle Favorite Process
	
	- parameter request: Favorite request model
	*/
    func processContactFavorite(_ request: ContactModel.Favorite.Request) {
        guard let id = request.id else {
            return
        }

        guard let favorite = request.isFavorite else {
            return
        }

        DispatchQueue.main.async {
            ContactProvider.request(.favorite(id: id, favorite: favorite), completion: { (result) in

                let message = "Unable to fetch from Contacts"

                switch result {
                case let .success(response):
                    do {
                        let data = try response.mapJSON()
                        if let value = Mapper<ContactListEntity>().map(JSONObject: data) {
                            print(value)
                            RealmHelper.sharedInstance.update(object: ContactListEntity.self, value: value)
                            var response = ContactModel.Favorite.Response()
                            response.contact = RealmHelper.sharedInstance.detail(object: ContactListEntity.self, predicate: "id = \(id)")
                            self.interactorOutputFavorite?.presentSuccessContactFavorite(response)
                        } else {
                            self.interactorOutputFavorite?.presentErrorContactFavorite(message)
                        }
                    } catch {
                        self.interactorOutputFavorite?.presentErrorContactFavorite(message)
                    }
                case let .failure(error):
                    self.interactorOutputFavorite?.presentErrorContactFavorite("\(error)")
                }
            })
        }
    }

}

extension ContactInteractor {

    func handleParsingData(data: Results<ContactListEntity>) -> [(key: String, value: [ContactListEntity])] {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map({ String($0) })
        var result = [String: [ContactListEntity]]()

        for letter in alphabet {
            result[letter] = []
            let matches = data.filter({ $0.firstName!.lowercased().hasPrefix(letter.lowercased()) })
            if !matches.isEmpty {
                for x in matches {
                    result[letter]?.append(x)
                }
            }
        }

        return result.sorted(by: { $0.0 < $1.0 })
    }
}
