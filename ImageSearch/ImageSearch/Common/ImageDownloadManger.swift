//
//  ImageDownloadManger.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation

import UIKit
class ImageDownloadManger: NSObject {
    static let shared = ImageDownloadManger()
    func downloadImage(_ urlString: String, completion: @escaping ((UIImage?) -> Void)) {
        downloadImageURL(urlString) { (data) in
            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
    private func downloadImageURL(_ urlString: String, completion: @escaping ((Data?) -> Void)) {
        if let cachedFile = getfile(urlString) {
            completion(cachedFile)
        } else  {
            download(urlString: urlString) { (fileUrl) in
                guard let fileUrl = fileUrl else {
                    completion(nil)
                    return
                }
                let name = urlString.fileName()
                if let destinationURl = self.documentsUrl()?.appendingPathComponent(name) {
                    do {
                        try FileManager.default.moveItem(at: fileUrl, to: destinationURl)
                        completion(self.getfile(urlString))
                    } catch  {
                        completion(nil)
                    }
                }
            }
        }
    }
    private func download(urlString: String, completion: @escaping ((URL?) -> Void)) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (url, response, error) in
            completion(url)
        })
        downloadTask.resume()
    }
}
extension ImageDownloadManger {
    private func getfileURL(_ fileURLString: String) -> URL? {
        let name = fileURLString.fileName()
        guard let path = filePath(name) else { return nil }
        if FileManager.default.fileExists(atPath: path) {
            return documentsUrl()?.appendingPathComponent(name)
        }
        return nil
    }
    private func getfile(_ fileURLString: String) -> Data? {
        if let fileURL = getfileURL(fileURLString) {
            do {
                return try Data(contentsOf: fileURL)
            } catch  {
                return nil
            }
        }
        return nil
    }
}
extension ImageDownloadManger {
    private func documentsUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    private func filePath(_ name: String) -> String? {
        if let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as NSString? {
            return path.appendingPathComponent(name)
        }
        return nil
    }
}
