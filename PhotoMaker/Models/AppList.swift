//
//  AppList.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 24.08.22.
//

import Foundation

class List {
    private let baseUrl = "https://junior.balinasoft.com/v2/api-docs?group=api2"
    var cellsData: [Content]?
    private var responseData: ListPhotos?
    private var currentPage: Int = 0
    
    
    
    func getListData() {
        guard let url = URL(string: "\(baseUrl)https://junior.balinasoft.com/api/v2/photo/type?page=\(currentPage)") else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else { return }
                do {
                    self.responseData = try JSONDecoder().decode(ListPhotos.self, from: data)
                }
                catch {
                    print(error)
                }
        }
        task.resume()
    }
    
    
    init() {
        self.getListData()
    }
}
