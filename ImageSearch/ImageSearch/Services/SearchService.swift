//
//  SearchService.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation
class SearchService:  NSObject {
    private let baseURLString = "https://contextualwebsearch-websearch-v1.p.rapidapi.com/"
    private  let headers = [
        "x-rapidapi-key": "06f00c26dbmsha6b76ae8bae8556p174db6jsn68de7de68759",
        "x-rapidapi-host": "contextualwebsearch-websearch-v1.p.rapidapi.com"
    ]
    
    func fetchImageList(urlParamString: String, completion : @escaping (ImageListModel?) -> ()) {
        let sImageSearchAPIURLString = "api/Search/ImageSearchAPI?"
        get(requestString: baseURLString+sImageSearchAPIURLString+urlParamString) { (imageList) in
            completion(imageList)
        }
    }
    
    private func get(requestString: String, completion : @escaping (ImageListModel?) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: requestString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask =  session.dataTask(with: request as URLRequest) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let imageData = try! jsonDecoder.decode(ImageListModel.self, from: data)
                completion(imageData)
            } else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
