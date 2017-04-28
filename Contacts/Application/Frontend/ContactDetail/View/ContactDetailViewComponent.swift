//
//  ContactDetailViewComponent.swift
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
* Setup ContactDetail ViewComponent
*/
class ContactDetailViewComponent: NSObject {

    // MARK: - Setup Variables
    weak var viewController: ContactDetailViewController?

    // MARK: - Set Data
    var contact: ContactListEntity?

    lazy var contactDetailTable: UITableView = {
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
        table.register(ContactDetailHeaderTableViewCell.self, forCellReuseIdentifier: "DetailHeaderCell")
        table.register(ContactDetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        return table
    }()

    var dataTitle: [String] = ["mobile", "email"]
    var dataValue: [String] = ["+6282384669700", "arimunandar.dev@gmail.com"]

    /**
    * Initializes: Setup Initial function for ContactDetail View Component
    */
    func setupComponent() {

        self.setupNavigationProperties()
        self.setupProperties()
        self.setupViews()
        self.setupFrames()

    }

    /**
    * Initializes: Setup Initial function for ContactDetail Navigation Item Properties
    */
    private func setupNavigationProperties() {
        self.viewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleShowUpdateContact))
    }

    /**
    * Initializes: Setup Initial function for ContactDetail Properties
    */
    private func setupProperties() {
        // Do someting...
    }

    /**
    * Initializes: Setup Initial function for Setup Views
    */
    private func setupViews() {
        self.viewController?.view.addSubview(self.contactDetailTable)
    }

    /**
    * Initializes: Setup Initial function for Setup Frames
    */
    private func setupFrames() {
        self.contactDetailTable <- [
            Top(),
            Left(),
            Right(),
            Bottom()
        ]
    }

}

/**
* Setup ContactDetail ViewComponent
*/
extension ContactDetailViewComponent {
    func handleShowUpdateContact() {
        guard let id = self.contact?.id else {
            return
        }
        self.viewController?.handleShowEditContact(id: id, contact: self.contact)
    }
}

/**
* Setup ContactDetail ViewComponent
*/
extension ContactDetailViewComponent: UITableViewDelegate {
    // Do Someting...
}

/**
* Setup ContactDetail ViewComponent
*/
extension ContactDetailViewComponent: UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderCell", for: indexPath) as! ContactDetailHeaderTableViewCell
            if let id = self.contact?.id, let firstName = self.contact?.firstName, let lastName = self.contact?.lastName, let img = self.contact?.profilePic, let favorite = self.contact?.favorite, let mobile = self.contact?.phoneNumber, let email = self.contact?.email {
                cell.setName = "\(firstName.capitalizingFirstLetter()) \(lastName.capitalizingFirstLetter())"
                cell.setProfileImage = img
                cell.setFavorite = favorite
                cell.setMobile = mobile
                cell.setEmail = email
                cell.setId = id
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! ContactDetailTableViewCell
            cell.setTitle = self.dataTitle[indexPath.row]
            if let mobile = self.contact?.phoneNumber, let email = self.contact?.email {
                switch indexPath.row {
                case 0:
                    cell.setValue = mobile
                case 1:
                    cell.setValue = email
                default:
                    break
                }
            }
            return cell
        }
    }
}
