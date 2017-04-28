//
//  ContactPresenterProtocol.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactPresenterInputProtocol: class {

    /**
	Setup handle create process
	
	- parameter request: create request model
	*/
    func setProcessContactCreate(_ request: ContactModel.Create.Request)

    /**
	Setup handle update process
	
	- parameter request: update request model
	*/
    func setProcessContactUpdate(_ request: ContactModel.Update.Request)

    /**
	Setup handle list process
	
	- parameter request: list request model
	*/
    func setProcessContactList(_ request: ContactModel.List.Request)

    /**
	Setup handle detail process
	
	- parameter request: detail request model
	*/
    func setProcessContactDetail(_ request: ContactModel.Detail.Request)

    /**
	Setup handle delete process
	
	- parameter request: delete request model
	*/
    func setProcessContactDelete(_ request: ContactModel.Delete.Request)

    /**
	Setup handle favorite process
	
	- parameter request: favorite request model
	*/
    func setProcessContactFavorite(_ request: ContactModel.Favorite.Request)

    // Setup function for Router
    /**
	Setup handle dismiss page
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateDismiss()

    /**
	Setup handle show page
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateShowFromList()

    /**
	Setup handle show page
	
	- parameter request: -
	*/
    func setProcessContactCreateOrUpdateShowFromDetail(_ id: Int?, contact: ContactListEntity?)

    /**
	Setup handle show page
	
	- parameter request: -
	*/
    func setProcessContactDetailShow(_ id: Int?)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactCreatePresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactCreate(_ response: ContactModel.Create.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactCreate(_ message: String)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactUpdatePresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactUpdate(_ response: ContactModel.Update.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactUpdate(_ message: String)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactListPresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactList(_ response: ContactModel.List.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactList(_ message: String)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactDetailPresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactDetail(_ response: ContactModel.Detail.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactDetail(_ message: String)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactDeletePresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactDelete(_ response: ContactModel.Delete.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactDelete(_ message: String)

}

/**
* Setup Contact Presenter Input Protocol
*/
protocol ContactFavoritePresenterOutputProtocol: class {

    /**
	Setup display success response
	
	- parameter viewModel: response model
	*/
    func displaySuccessContactFavorite(_ response: ContactModel.Favorite.Response)

    /**
	Setup display error response
	
	- parameter message:   message model
	*/
    func displayErrorContactFavorite(_ message: String)

}
