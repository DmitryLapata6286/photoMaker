//
//  NetHelper.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 27.08.22.
//

import Foundation
import UIKit

class NetWorker {
    
    func uploadDataWithImage(dataModel: SendableData,
                             then handler: @escaping (Result<Data, Error>) -> Void){
        // your image from Image picker, as of now I am picking image from the bundle
        
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo") else { return }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "post"
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        urlRequest.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        
        //attachmentKey is the api parameter name for your image do ask the API developer for this
        // file name is the name which you want to give to the file
        guard let photo = dataModel.photo else { return }
        let requestData = createRequestBody(photo: photo,
                                            typeId: String(dataModel.typeId),
                                            name: dataModel.name,
                                            boundary: bodyBoundary,
                                            fileName: "example")
        
        urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
        urlRequest.httpBody = requestData
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
//            if(error == nil && data != nil && data?.count != 0){
//                do {
//                    print(data) // for tests
//                }
//                
//                //            catch let decodingError {
//                //                debugPrint(decodingError)
//                //            }
//            }
        }.resume()
    }
    
    func createRequestBody(photo: Data,
                           typeId: String,
                           name: String,
                           boundary: String,
                           fileName: String) -> Data{
        let lineBreak = "\r\n"
        var requestBody = Data()
        
        requestBody.append(typeId.data(using: .utf8)!)
        requestBody.append(name.data(using: .utf8)!)
        
        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Type: image/jpeg \(lineBreak + lineBreak)" .data(using: .utf8)!) // you can change the type accordingly if you want to
        requestBody.append(photo)
        requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        
        return requestBody
    }
}
