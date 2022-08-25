//
//  ViewController.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedID: Int = 0
    var neededUpdate: Bool = true
    var currentPage: Int = 0
    
    private var tableView = UITableView()
    
    var listModel = List()
    
    var realModel: [Content] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        setTableView()
        
        listModel.dataGotClosure = { contents in
            self.realModel.append(contentsOf: contents ?? [])
            self.neededUpdate = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        listModel.getListData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset + 50

        if distanceFromBottom < height, neededUpdate {
            neededUpdate = false
            currentPage += 1
            listModel.getListData(page: currentPage)
            print("You reached end of the table")
        }
    }
    
    // MARK: - Methods
    func setTableView () {
       
        
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "testID")
        
        tableView.register(CellView.self,
                           forCellReuseIdentifier: CellView.identifier)
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realModel.count // cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as? CellView else { fatalError() }
        //        // TODO: - add data to view cell
        //
        //        cell.nameLabel.text = listModel.cellsData?[indexPath.row].name
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "testID", for: indexPath) as? TestTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: realModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - logic with sending photo to server
        selectedID = indexPath.row
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .camera
        present(vc, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
//        guard let cell = tableView.cellForRow(at: IndexPath(row: selectedID, section: 0)) as? TestTableViewCell else {
//            return
//        }
//        cell.iv.image = image
        let coder = JSONEncoder()
        guard let data = try? coder.encode(SendableData(typeId: selectedID, photo: image.pngData()))
        else {
            return
        }
        listModel.sendRequest(body: data, then: { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        })
        picker.dismiss(animated: true, completion: nil)
    }

}
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }

