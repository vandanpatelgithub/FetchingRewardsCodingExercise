//
//  ItemsListVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import UIKit

protocol ItemsListViewable: class {
    func display(groupedItems: [Dictionary<Int, [Item]>.Element])
    func display(error: String)
}

final class ItemsListVC: UIViewController {
    
    // MARK: - Properties
    // presenter is forced-unwrap on purpose. if it is nil, I have nothing to show on view
    var presenter: ItemsListPresentable!
    private var groupedItems = [Dictionary<Int, [Item]>.Element]()
    private let cellReusableID = "itemCell"
    
    private var tableView = UITableView()
    private var searchBar = UISearchBar()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
        configureUI()
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "List of Items"
        
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        setupSearchBarConstraints()
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReusableID)
        
        setupConstraintsForTableView()
    }
}

// MARK: - Set up constraints

extension ItemsListVC {
    private func setupConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}

// MARK: - VIPER Protocol Conformance

extension ItemsListVC: ItemsListViewable {
    func display(groupedItems: [Dictionary<Int, [Item]>.Element]) {
        self.groupedItems = groupedItems
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func display(error: String) {
        showAlert(title: "ERROR", message: error)
    }
}

// MARK: - TableView DataSource & Delegate

extension ItemsListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = groupedItems[section].key.sectionTitle
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedItems[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = groupedItems[indexPath.section].value[indexPath.row].name ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReusableID, for: indexPath)
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

// MARK: SearchBar Delegate

extension ItemsListVC: UISearchBarDelegate {    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchResults(forText: searchText)
    }
}
