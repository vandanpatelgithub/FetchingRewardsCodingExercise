//
//  ItemsListDiffableVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/26/20.
//

import UIKit

final class ItemsListDiffableVC: UIViewController {
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    private var groupedItems = [[Int: [Item]]]()
    
    var presenter: ItemsListPresentable!
    
    private let cellReusableID = "itemCell"
    private let sectionReusableID = "sectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        presenter.didLoadView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReusableID)
        tableView.register(ItemHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionReusableID)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReusableID, for: indexPath)
            cell.textLabel?.text = item.name ?? ""
            return cell
        })
        tableView.dataSource = dataSource
        tableView.delegate = self
        update(with: groupedItems)
    }
}

extension ItemsListDiffableVC {
    private func update(with groupedItems: [[Int: [Item]]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        for dict in groupedItems {
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionReusableID) as! ItemHeaderView
        headerView.configureHeader(withTitle: groupedItems[section].keys.first?.sectionTitle ?? "")
        return headerView
    }
}

extension ItemsListDiffableVC: ItemsListViewable {
    func display(groupedItems: [Int: [Item]]) {
        for (key, value) in groupedItems {
            self.groupedItems.append([key: value])
        }
        update(with: self.groupedItems)
    }
    
    func display(error: String) {
        showAlert(title: "ERROR", message: error)
    }
}
