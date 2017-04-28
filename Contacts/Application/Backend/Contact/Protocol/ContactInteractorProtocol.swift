//
//  ContactInteractorProtocol.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup Contact Interactor Input Protocol
*/
protocol ContactInteractorInputProtocol: class {

    /**
	Setup handle create process
	
	- parameter request: create request model
	*/
    func processContactCreate(_ request: ContactModel.Create.Request)

    /**
	Setup handle update process
	
	- parameter request: update request model
	*/
    func processContactUpdate(_ request: ContactModel.Update.Request)

    /**
	Setup handle list process
	
	- parameter request: list request model
	*/
    func processContactList(_ request: ContactModel.List.Request)

    /**
	Setup handle detail process
	
	- parameter request: detail request model
	*/
    func processContactDetail(_ request: ContactModel.Detail.Request)

    /**
	Setup handle delete process
	
	- parameter request: delete request model
	*/
    func processContactDelete(_ request: ContactModel.Delete.Request)

    /**
	Setup handle favorite process
	
	- parameter request: favorite request model
	*/
    func processContactFavorite(_ request: ContactModel.Favorite.Request)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactCreateInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactCreate(_ response: ContactModel.Create.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactCreate(_ message: String)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactUpdateInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactUpdate(_ response: ContactModel.Update.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactUpdate(_ message: String)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactListInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactList(_ response: ContactModel.List.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactList(_ message: String)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactDetailInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactDetail(_ response: ContactModel.Detail.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactDetail(_ message: String)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactDeleteInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactDelete(_ response: ContactModel.Delete.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactDelete(_ message: String)

}

/**
* Setup Contact Interactor Output Protocol
*/
protocol ContactFavoriteInteractorOutputProtocol: class {

    /**
	Setup present success response
	
	- parameter response: response model
	*/
    func presentSuccessContactFavorite(_ response: ContactModel.Favorite.Response)

    /**
	Setup present error response
	
	- parameter message:   message model
	*/
    func presentErrorContactFavorite(_ message: String)

}
