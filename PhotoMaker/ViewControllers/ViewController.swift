//
//  ViewController.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    private var tableView = UITableView()
    
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
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: CellView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath)

        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        return cell
    }
}

