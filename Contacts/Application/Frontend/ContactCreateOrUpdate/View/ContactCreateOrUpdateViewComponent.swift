//
//  ContactCreateOrUpdateViewComponent.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import EasyPeasy

/**
* Setup ContactCreateOrUpdate ViewComponent
*/
class ContactCreateOrUpdateViewComponent: NSObject {

    // MARK: - Setup Variables
    weak var viewController: ContactCreateOrUpdateViewController?

    lazy var contactCreateOrUpdateTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets(top: 0, left: Sizes.WIDTH, bottom: 0, right: 0)
        table.separatorColor = Colors.LIGHT_GREY
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 100
        table.isHidden = false
        table.backgroundColor = Colors.WHITE
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ContactHeaderCreateOrUpdateTableViewCell.self, forCellReuseIdentifier: "ContactHeaderCell")
        table.register(ContactCreateOrUpdateTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        return table
    }()

    var dataTitle: [String] = ["First Name", "Last Name", "Mobile", "Email"]
    var requestUpdate = ContactModel.Update.Request()
    var profileImage: UIImage?
    var contact: ContactListEntity?

    /**
    * Initializes: Setup Initial function for ContactCreateOrUpdate View Component
    */
    func setupComponent() {

        self.setupNavigationProperties()
        self.setupProperties()
        self.setupViews()
        self.setupFrames()

    }

    /**
    * Initializes: Setup Initial function for ContactCreateOrUpdate Navigation Item Properties
    */
    private func setupNavigationProperties() {
        self.viewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissCreateOrUpdateContactPage))
        self.viewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneCreateOrUpdateContact))
    }

    /**
    * Initializes: Setup Initial function for ContactCreateOrUpdate Properties
    */
    private func setupProperties() {
        // Do someting...
    }

    /**
    * Initializes: Setup Initial function for Setup Views
    */
    private func setupViews() {
        self.viewController?.view.addSubview(self.contactCreateOrUpdateTable)
    }

    /**
    * Initializes: Setup Initial function for Setup Frames
    */
    private func setupFrames() {
        self.contactCreateOrUpdateTable <- [
            Top(),
            Left(),
            Right(),
            Bottom()
        ]
    }

}

/**
* Setup ContactCreateOrUpdate ViewComponent
*/
extension ContactCreateOrUpdateViewComponent {
    func handleDismissCreateOrUpdateContactPage() {
        self.viewController?.handleDismissCreateOrUpdateContactPage()
    }

    func handleDoneCreateOrUpdateContact() {		
        self.viewController?.handleDoneCreateOrUpdateContact()
    }
}

/**
* Setup ContactCreateOrUpdate ViewComponent
*/
extension ContactCreateOrUpdateViewComponent: UITableViewDelegate {
    // Do Someting...
}

/**
* Setup ContactCreateOrUpdate ViewComponent
*/
extension ContactCreateOrUpdateViewComponent: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.dataTitle.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactHeaderCell", for: indexPath) as! ContactHeaderCreateOrUpdateTableViewCell
            cell.delegate = self
            cell.setImage = profileImage
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCreateOrUpdateTableViewCell
            cell.delegate = self
            cell.setTitle = self.dataTitle[indexPath.row]
            cell.setTag = indexPath.row

            switch indexPath.row {
            case 0:
				cell.inputTextField.text = ""
                cell.inputTextField.keyboardType = .default
                if let firstName = self.contact?.firstName {
                    cell.inputTextField.text = firstName
                }
				self.requestUpdate.firstName = cell.inputTextField.text
            case 1:
				cell.inputTextField.text = ""
                cell.inputTextField.keyboardType = .default
                if let lastName = self.contact?.lastName {
                    cell.inputTextField.text = lastName
                }
				self.requestUpdate.lastName = cell.inputTextField.text
            case 2:
				cell.inputTextField.text = ""
                cell.inputTextField.keyboardType = .phonePad
                if let phoneNumber = self.contact?.phoneNumber {
                    cell.inputTextField.text = phoneNumber
                }
				self.requestUpdate.phoneNumber = cell.inputTextField.text
            case 3:
				cell.inputTextField.text = ""
                cell.inputTextField.keyboardType = .emailAddress
                if let email = self.contact?.email {
                    cell.inputTextField.text = email
                }
				self.requestUpdate.email = cell.inputTextField.text
            default:
                break
            }

            return cell
        }
    }
}
