//
//  AppList.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 24.08.22.
//

import Foundation
import UIKit

class List {
    private let baseUrl = "https://junior.balinasoft.com/"
    var cellsData: [Content]?
    private var responseData: ListPhotos? {
        didSet {
            networkClosure?(responseData?.content)
        }
    }
    
    var networkClosure: (([Content]?) -> Void)?
    
    
    func getListData(page: Int = 0) {
        guard let url = URL(string: "\(baseUrl)api/v2/photo/type?page=\(page)") else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else { return }
            self.responseData = try? JSONDecoder().decode(ListPhotos.self, from: data)
        }
        task.resume()
    }
    
    func sendRequest(
        body: Data,
        then handler: @escaping (Result<Data, Error>) -> Void
    ) {
        
        let boundary = UUID().uuidString
        guard let url = URL(string: "\(baseUrl)api/v2/photo") else { return }
        // To ensure that our request is always sent, we tell
        // the system to ignore all local cache data:
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        request.httpMethod = "POST"
        
        request.httpBody = body
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, response, error in

                guard let data = data else {
                    return
                }

                if let error = error {
                    handler(.failure(error))
                } else {
                    handler(.success(data))
                }
            }
        )

        task.resume()
    }
}

protocol CellViewModelProtocol {
    var nameString: String { get }
    var realImage: UIImage { get }
}

