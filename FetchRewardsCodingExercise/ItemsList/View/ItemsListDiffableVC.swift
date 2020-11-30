//
//  ItemsListDiffableVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/26/20.
//

import UIKit

final class ItemsListDiffableVC: UIViewController {
    
    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var searchBar = UISearchBar()
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    private var items = [[Int: [Item]]]()
    
    var presenter: ItemsListPresentable!
    
    private let cellReusableID = "itemCell"
    private let sectionReusableID = "sectionCell"
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
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
    
    private func addTableView() {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReusableID)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: sectionReusableID)
        
        view.addSubview(tableView)
        setupConstraintsForTableView()
    }
    
    private func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        setupSearchBarConstraints()
    }
        
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReusableID, for: indexPath)
            cell.textLabel?.text = item.name ?? ""
            return cell
        })
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}

extension ItemsListDiffableVC {
    private func update(with items: [[Int: [Item]]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        for dict in items {
            for (key, value) in dict {
                snapshot.appendSections([Section(sectionName: key.sectionTitle)])
                snapshot.appendItems(value)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension ItemsListDiffableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionReusableID)
        headerView?.textLabel?.text = items[section].keys.first?.sectionTitle ?? ""
        return headerView
    }
}

extension ItemsListDiffableVC: ItemsListViewable {
    func display(groupedItems: [Int: [Item]]) {
        self.items.removeAll()
        for (key, value) in groupedItems.sorted(by: { $0.key < $1.key}) {
            self.items.append([key: value])
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.update(with: self?.items ?? [])
        }
    }
    
    func display(error: String) {
        showAlert(title: "ERROR", message: error)
    }
}

// MARK: - Setup Extensions

extension ItemsListDiffableVC {
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

extension ItemsListDiffableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchResults(forText: searchText)
    }
}
