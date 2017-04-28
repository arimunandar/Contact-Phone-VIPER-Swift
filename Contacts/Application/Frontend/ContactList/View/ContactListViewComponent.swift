//
//  ContactListViewComponent.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import EasyPeasy
import RealmSwift

/**
* Setup ContactList ViewComponent
*/
class ContactListViewComponent: NSObject {

    // MARK: - Setup Variables
    weak var viewController: ContactListViewController?

    // MARK: - Initial Data
    var contactList: [(key: String, value: [ContactListEntity])]?

    // MARK - Initial UITableView
    lazy var contactListTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets(top: 0, left: Sizes.WIDTH, bottom: 0, right: 0)
        table.separatorColor = Colors.LIGHT_GREY
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 100
        table.isHidden = true
        table.backgroundColor = Colors.WHITE
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ContactListTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        return table
    }()

    // MARK - Initial Label
    var alfabetLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ\n#\n", comment: "")
        label.textColor = Colors.DARK_GREY
        label.backgroundColor = Colors.CLEAR
        label.font = UIFont(name: "SanFranciscoText-Semibold", size: FontSize.NORMAL)
        label.isHidden = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK - Initial Label
    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Get Data Contacts...", comment: "")
        label.textColor = Colors.DARK_GREY
        label.backgroundColor = Colors.CLEAR
        label.font = UIFont.boldSystemFont(ofSize: FontSize.LARGE)
        label.textAlignment = .center
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.backgroundColor = Colors.CLEAR
        refresh.tintColor = Colors.DARK_GREY
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresh
    }()

    /**
    * Initializes: Setup Initial function for ContactList View Component
    */
    func setupComponent() {

        self.setupNavigationProperties()
        self.setupProperties()
        self.setupViews()
        self.setupFrames()

    }

    /**
    * Initializes: Setup Initial function for ContactList Navigation Item Properties
    */
    private func setupNavigationProperties() {
        let titleLabel = UILabel()
        titleLabel.text = "Contact"
        titleLabel.textColor = Colors.DARK_GREY
        titleLabel.font = UIFont(name: "SanFranciscoText-Semibold", size: Sizes._20)
        self.viewController?.navigationItem.title = "Contact"
        self.viewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: nil, action: nil)
        self.viewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleShowCreateContactPage))
    }

    /**
    * Initializes: Setup Initial function for ContactList Properties
    */
    private func setupProperties() {
        // Do someting...
    }

    /**
    * Initializes: Setup Initial function for Setup Views
    */
    private func setupViews() {
        self.contactListTable.addSubview(self.refreshControl)
        self.viewController?.view.addSubview(self.statusLabel)
        self.viewController?.view.addSubview(self.contactListTable)
        self.viewController?.view.addSubview(self.alfabetLabel)
    }

    /**
    * Initializes: Setup Initial function for Setup Frames
    */
    private func setupFrames() {
        self.statusLabel <- [
            CenterX(),
            CenterY(),
            Height(Sizes._30)
        ]

        self.contactListTable <- [
            Top(),
            Left(),
            Right(),
            Bottom()
        ]

        self.alfabetLabel <- [
            Top(Sizes._50),
            Right(),
            Width(Sizes._15),
            Bottom(Sizes._50)
        ]
    }

}

/**
* Setup ContactList ViewComponent
*/
extension ContactListViewComponent {
    func handleShowCreateContactPage() {
        self.viewController?.handleShowCreateContactPage()
    }

    func handleRefresh() {
        self.viewController?.handleProcess(isLoad: true)
    }
}

/**
* Setup ContactList ViewComponent
*/
extension ContactListViewComponent: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.contactList {
            let sectionString = Array(data)[indexPath.section]
            self.viewController?.handleShowDetailContact(id: sectionString.value[indexPath.row].id)
        }
    }
}

/**
* Setup ContactList ViewComponent
*/
extension ContactListViewComponent: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let data = self.contactList {
            return data.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.contactList {
            let sectionString = Array(data)[section]
            return sectionString.value.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactListTableViewCell
        if let data = self.contactList {
            let sectionString = Array(data)[indexPath.section]
            cell.setContact = sectionString.value[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = Colors.LIGHT_GREY
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "SanFranciscoText-Bold", size: FontSize.LARGE)
        titleLabel.textColor = Colors.DARK_GREY
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let data = self.contactList {
            let sectionString = Array(data)[section]
            titleLabel.text = sectionString.key
        }
        header.addSubview(titleLabel)
        titleLabel <- [
            Top(),
            Left(Padding._16),
            Right(Padding._16),
            Bottom()
        ]
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let data = self.contactList {
            let sectionString = Array(data)[section]
            return sectionString.value.count != 0 ? Sizes._30 : 0
        }
        return 0
    }
}
