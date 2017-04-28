//
//  ContactCreateOrUpdateViewController.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup ContactCreateOrUpdate ViewController
*/
class ContactCreateOrUpdateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - Setup Variables
    var presenterContactInput: ContactPresenterInputProtocol!
    var viewComponent: ContactCreateOrUpdateViewComponent!

    var isCreate: Bool = false
    var idContact: Int? = 0
    var contact: ContactListEntity?

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Setup ContactCreateOrUpdateViewController Dependencies
        ContactCreateOrUpdateDependencies.sharedInstance.configure(viewController: self)

        // MARK: - Setup ContactCreateOrUpdateViewComponent
        self.setupComponent()

        print(idContact != nil ? idContact! : 0)
        self.viewComponent.contact = RealmHelper.sharedInstance.detail(object: ContactListEntity.self, predicate: "id = \(idContact != nil ? idContact! : 0)")
        self.viewComponent.contactCreateOrUpdateTable.reloadData()

    }

}

/**
* Setup ContactCreateOrUpdate View Controller
*/
extension ContactCreateOrUpdateViewController {

    // MARK - Initial function for Setup ContactCreateOrUpdate View Component
    internal func setupComponent() {

        self.viewComponent.setupComponent()

    }

}

/**
* Setup ContactCreateOrUpdate View Controller
*/
extension ContactCreateOrUpdateViewController: ContactCreatePresenterOutputProtocol {
    func displaySuccessContactCreate(_ response: ContactModel.Create.Response) {
        print(response)
        self.presenterContactInput.setProcessContactCreateOrUpdateDismiss()
    }

    func displayErrorContactCreate(_ message: String) {
        print(message)
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/**
* Setup ContactCreateOrUpdate View Controller
*/
extension ContactCreateOrUpdateViewController: ContactUpdatePresenterOutputProtocol {
    func displaySuccessContactUpdate(_ response: ContactModel.Update.Response) {
        print(response)
        self.presenterContactInput.setProcessContactCreateOrUpdateDismiss()
    }

    func displayErrorContactUpdate(_ message: String) {
        print(message)
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/**
* Setup ContactCreateOrUpdate View Controller
*/
extension ContactCreateOrUpdateViewController {
    func selectPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func handleDismissCreateOrUpdateContactPage() {
        self.dismiss(animated: true, completion: nil)
    }

    func handleDoneCreateOrUpdateContact() {
        print("OK", isCreate)
        guard let id = idContact else {
            return
        }

        guard let firstName = self.viewComponent.requestUpdate.firstName else {
            return
        }

        guard let lastName = self.viewComponent.requestUpdate.lastName else {
            return
        }

        guard let phoneNumber = self.viewComponent.requestUpdate.phoneNumber else {
            return
        }

        guard let email = self.viewComponent.requestUpdate.email else {
            return
        }

        print(id, firstName, lastName, email, phoneNumber)

        // MARK: - Sample Create
        if isCreate {
            var request = ContactModel.Create.Request()
            request.firstName = firstName
            request.lastName = lastName
            request.email = email
            request.phoneNumber = phoneNumber
            request.favorite = false
            self.presenterContactInput.setProcessContactCreate(request)
        } else {
            var request = ContactModel.Update.Request()
            request.id = id
            request.firstName = firstName
            request.lastName = lastName
            request.email = email
            request.phoneNumber = phoneNumber
            self.presenterContactInput.setProcessContactUpdate(request)
        }
    }
}

extension ContactCreateOrUpdateViewController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        var newImage: UIImage

        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // do something interesting here!
        print(newImage.size)
        self.viewComponent.profileImage = newImage
        self.viewComponent.contactCreateOrUpdateTable.reloadData()

        dismiss(animated: true)
    }
}
