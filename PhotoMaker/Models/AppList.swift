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
            dataGotClosure?(responseData?.content)
        }
    }
    private var currentPage: Int = 0
    
    var dataGotClosure: (([Content]?) -> Void)?
    
    
    func getListData(page: Int = 0) {
        guard let url = URL(string: "\(baseUrl)api/v2/photo/type?page=\(page)") else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else { return }
            self.responseData = try? JSONDecoder().decode(ListPhotos.self, from: data)
        }
        task.resume()
    }
    
//    func uploadImage(paramName: String, fileName: String, image: UIImage, body: Data) {
//        guard let url = URL(string: "\(baseUrl)api/v2/photo") else { return }
//
//        // generate boundary string using a unique per-app string
//        let boundary = UUID().uuidString
//
//        let session = URLSession.shared
//
//        // Set the URLRequest to POST and to the specified URL
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//
//        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//        // And the boundary is also set here
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
////        var data = Data()
//
////        // Add the image data to the raw http request data
////        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
////        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
////        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
////        data.append(image.pngData()!)
////
////        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
////        data.append("\r\n--\(body)--\r\n".data(using: .utf8)!)
//
//        // Send a POST request to the URL, with the data we created earlier
//        session.uploadTask(with: urlRequest, from: body, completionHandler: { responseData, response, error in
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print(json)
//                }
//            }
//        }).resume()
//    }
    
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
        
        // Add the image data to the raw http request data
//        var data = body
//        
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(image.pngData()!)
//        
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//        data.append("\r\n--\(body)--\r\n".data(using: .utf8)!)
        
        
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

    
    
    //    init() {
    //        self.getListData()
    //    }
}

protocol CellViewModelProtocol {
    var nameString: String { get }
    var realImage: UIImage { get }
}

