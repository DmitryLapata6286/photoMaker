//
//  AppList.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 24.08.22.
//

import Foundation

class List {
    private let baseUrl = "https://junior.balinasoft.com/"
    var cellsData: [Content]?
    private var responseData: ListPhotos?
    private var currentPage: Int = 0
    
    
    
    func getListData() {
        guard let url = URL(string: "\(baseUrl)api/v2/photo/type?page=\(currentPage)") else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else { return }
            self.responseData = try? JSONDecoder().decode(ListPhotos.self, from: data)

        }
        task.resume()
    }
    
    func makePhoto() {
        
    }
    
    
    init() {
        self.getListData()
    }
}
