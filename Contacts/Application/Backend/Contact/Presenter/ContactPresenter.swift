//
//  ContactPresenter.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup Contact Presenter with Contact Presenter Input Protocol
*/
class ContactPresenter: ContactPresenterInputProtocol {

    // MARK: - Setup Variables
    internal var router: ContactRouter!
    var interactorInput: ContactInteractorInputProtocol?
    weak var presenterOutputCreate: ContactCreatePresenterOutputProtocol?
    weak var presenterOutputUpdate: ContactUpdatePresenterOutputProtocol?
    weak var presenterOutputList: ContactListPresenterOutputProtocol?
    weak var presenterOutputDetail: ContactDetailPresenterOutputProtocol?
    weak var presenterOutputDelete: ContactDeletePresenterOutputProtocol?
    weak var presenterOutputFavorite: ContactFavoritePresenterOutputProtocol?

    init() {
        // Do someting...
    }

    /**
	Setup Process
	
	- parameter request: request model
	*/
    func setProcessContactCreate(_ request: ContactModel.Create.Request) {
        self.interactorInput?.processContactCreate(request)
    }

    /**
    Setup Process
    
    - parameter request: request model
    */
    func setProcessContactUpdate(_ request: ContactModel.Update.Request) {
        self.interactorInput?.processContactUpdate(request)
    }

    /**
    Setup Process
    
    - parameter request: request model
    */
    func setProcessContactList(_ request: ContactModel.List.Request) {
        self.interactorInput?.processContactList(request)
    }

    /**
    Setup Process
    
    - parameter request: request model
    */
    func setProcessContactDetail(_ request: ContactModel.Detail.Request) {
        self.interactorInput?.processContactDetail(request)
    }

    /**
    Setup Process
    
    - parameter request: request model
    */
    func setProcessContactDelete(_ request: ContactModel.Delete.Request) {
        self.interactorInput?.processContactDelete(request)
    }

    /**
	Setup Process
	
	- parameter request: request model
	*/
    func setProcessContactFavorite(_ request: ContactModel.Favorite.Request) {
        self.interactorInput?.processContactFavorite(request)
    }

    /**
	Setup Process
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateDismiss() {
        self.router.handleDismissCreateOrUpdatePage()
    }

    /**
	Setup Process
	
	- parameter request: -
	*/
    func setProcessContactDetailShow(_ id: Int? = 0) {
        self.router.handleShowDetailPage(id)
    }

    /**
	Setup Process
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateShowFromList() {
        self.router.handleShowCreateOrUpdatePageFromListPage()
    }

    /**
	Setup Process
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateShowFromDetail(_ id: Int? = 0, contact: ContactListEntity?) {
        self.router.handleShowCreateOrUpdatePageFromDetailPage(id, contact: contact)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactCreateInteractorOutputProtocol {

    /**
	Setup Present Success Response
	
	- parameter response: response model
	*/
    func presentSuccessContactCreate(_ response: ContactModel.Create.Response) {
        self.presenterOutputCreate?.displaySuccessContactCreate(ContactModel.Create.Response())
    }

    /**
	Setup Present Error Response
	
	- parameter message:   message model
	*/
    func presentErrorContactCreate(_ message: String) {
        self.presenterOutputCreate?.displayErrorContactCreate(message)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactUpdateInteractorOutputProtocol {

    /**
    Setup Present Success Response
    
    - parameter response: response model
    */
    func presentSuccessContactUpdate(_ response: ContactModel.Update.Response) {
        self.presenterOutputUpdate?.displaySuccessContactUpdate(ContactModel.Update.Response())
    }

    /**
    Setup Present Error Response
    
    - parameter message:   message model
    */
    func presentErrorContactUpdate(_ message: String) {
        self.presenterOutputUpdate?.displayErrorContactUpdate(message)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactListInteractorOutputProtocol {

    /**
    Setup Present Success Response
    
    - parameter response: response model
    */
    func presentSuccessContactList(_ response: ContactModel.List.Response) {
        self.presenterOutputList?.displaySuccessContactList(ContactModel.List.Response(contacts: response.contacts))
    }

    /**
    Setup Present Error Response
    
    - parameter message:   message model
    */
    func presentErrorContactList(_ message: String) {
        self.presenterOutputList?.displayErrorContactList(message)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactDetailInteractorOutputProtocol {

    /**
    Setup Present Success Response
    
    - parameter response: response model
    */
    func presentSuccessContactDetail(_ response: ContactModel.Detail.Response) {
        self.presenterOutputDetail?.displaySuccessContactDetail(ContactModel.Detail.Response(contact: response.contact))
    }

    /**
    Setup Present Error Response
    
    - parameter message:   message model
    */
    func presentErrorContactDetail(_ message: String) {
        self.presenterOutputDetail?.displayErrorContactDetail(message)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactDeleteInteractorOutputProtocol {

    /**
    Setup Present Success Response
    
    - parameter response: response model
    */
    func presentSuccessContactDelete(_ response: ContactModel.Delete.Response) {
        self.presenterOutputDelete?.displaySuccessContactDelete(response)
    }

    /**
    Setup Present Error Response
    
    - parameter message:   message model
    */
    func presentErrorContactDelete(_ message: String) {
        self.presenterOutputDelete?.displayErrorContactDelete(message)
    }

}

/**
* Setup Contact Presenter with Contact Interactor Output Protocol
*/
extension ContactPresenter: ContactFavoriteInteractorOutputProtocol {

    /**
	Setup Present Success Response
	
	- parameter response: response model
	*/
    func presentSuccessContactFavorite(_ response: ContactModel.Favorite.Response) {
        self.presenterOutputFavorite?.displaySuccessContactFavorite(response)
    }

    /**
	Setup Present Error Response
	
	- parameter message:   message model
	*/
    func presentErrorContactFavorite(_ message: String) {
        self.presenterOutputFavorite?.displayErrorContactFavorite(message)
    }

}
