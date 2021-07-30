//
//  ImagePopupViewController.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import UIKit
class ImagePopupViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        if let url = imageUrl {
            ImageDownloadManger.shared.downloadImage(url) { [weak self] (image) in
                DispatchQueue.main.async {
                self?.imageView.image = image
                }
            }
        }
    }
}
