//
//  ExampleListViewController.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

protocol ExampleListFlowDelegate: AnyObject {
    func exampleItemSelected(_ item: ExampleItem, in viewController: ExampleListViewController)
}

final class ExampleListViewController: BaseViewController<ExampleListViewModeling> {
    weak var flowDelegate: ExampleListFlowDelegate?

    private weak var tableView: UITableView!

    // MARK: Initializers

    override init(viewModel: ExampleListViewModeling) {
        super.init(viewModel: viewModel)
        self.title = "ACKategories"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.indexPathsForVisibleRows?.forEach { tableView.deselectRow(at: $0, animated: true) }
    }
}

extension ExampleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell: TitleSubtitleTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        return cell
    }
}

extension ExampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flowDelegate?.exampleItemSelected(viewModel.items[indexPath.row], in: self)
    }
}
