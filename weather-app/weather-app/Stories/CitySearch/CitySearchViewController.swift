//
//  CitySearchViewController.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

final class CitySearchViewController: UIViewController  {
    
    @IBOutlet private weak var searchField: SearchField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private var viewModel: CitySearchViewModelProtocol
    
    init(viewModel: CitySearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: CitySearchViewController.nibName,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }

    private func prepareViews() {
        viewModel.delegate = self
        searchField.searchFieldDelegate = self
        tableView.dataSource = self
        tableView.delegate = self
        errorLabel.isHidden = true
        navigationItem.title = "CitySearchTitle".localized
        loadingIndicator.stopAnimating()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.nibName)
    }
}

extension CitySearchViewController: SearchTextFieldDelegate {
    func textForSearchReceived(_ text: String) {
        loadingIndicator.startAnimating()
        viewModel.getViewData(for: text)
    }
}

extension CitySearchViewController: CitySearchViewModelDelegate {
    func errorReceived(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        tableView.reloadData()
        loadingIndicator.stopAnimating()
    }
    
    func viewDataUpdated() {
        errorLabel.isHidden = true
        tableView.reloadData()
        loadingIndicator.stopAnimating()
    }
}

extension CitySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewData[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nibName) else { return UITableViewCell() }
        let item = viewModel.viewData[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.text
        return cell
    }
}

extension CitySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Cell selected: \(indexPath)")
        viewModel.prepareSearchDetails(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        viewModel.viewData[section].header
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = viewModel.viewData[indexPath.section].items[indexPath.row]
        if let id = item.id, editingStyle == .delete {
            NSLog("Cell delete: \(indexPath)")
            viewModel.deleteLastCity(by: id)
            tableView.reloadData()
        }
    }
}
