//
//  Models.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import Foundation
import UIKit

struct ListPhotos: Codable {
    let content: [Content]?
    let page, pageSize, totalElements, totalPages: Int?
}

struct SendableData: Encodable {
    let typeId: Int
    let name: String = "Lapata D."
    let photo: Data?
    
}

struct Content: Codable, CellViewModelProtocol {
    
    let id: Int?
    let name, image: String?
    
    var nameString: String {
        return name ?? ""
    }
    
    var realImage: UIImage {
        if let img = image {
            if let url = URL(string: img) {
                return loadImage(url: url)
            }
            return UIImage()
        }
        return UIImage()
    }
}


    func loadImage(url: URL) -> UIImage {
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            let image = UIImage(data: imageData) ?? UIImage()
            return image
        }
        return UIImage()
    }




