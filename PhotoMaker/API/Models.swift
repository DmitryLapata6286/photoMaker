//
//  Models.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import Foundation

struct Welcome: Codable {
    let content: [Content]?
    let page, pageSize, totalElements, totalPages: Int?
}

struct Content: Codable {
    let id: Int?
    let name, image: String?
}
//
// To read values from URLs:
//
//   let task = URLSession.shared.contentTask(with: url) { content, response, error in
//     if let content = content {
//       ...
//     }
//   }
//   task.resume()


// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

