//
//  ViewController.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView = UITableView()
    
    var listModel = List()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Methods
    func setTableView () {
        self.view.addSubview(tableView)
        
        tableView.register(CellView.self,
                           forCellReuseIdentifier: CellView.identifier)
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as? CellView else { fatalError() }
        // TODO: - add data to view cell

        cell.nameLabel.text = listModel.cellsData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: - logic with sending photo to server
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

