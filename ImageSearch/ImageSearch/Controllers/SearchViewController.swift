//
//  ViewController.swift
//  ImageSearch
//
//  Created by You on 29/07/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingMoreLabel: UILabel!
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageListTableView: UITableView! {
        didSet {
            imageListTableView.delegate = self
        }
    }
    private var dataSource : ImageListTableViewDataSource<ImageListCell,ImageDataModel>!

    private var imageListViewModel : ImageListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    
    func callToViewModelForUIUpdate(){
        self.imageListViewModel =  ImageListViewModel()
        self.imageListViewModel.bindImageListViewModel = {
            self.updateDataSource()
        }
        self.imageListViewModel.showLoader = {
            DispatchQueue.main.async {
                self.loadingLabel.isHidden = false
            }
        }
        self.imageListViewModel.hideLoader = {
            DispatchQueue.main.async {
                self.loadingLabel.isHidden = true
                self.loadingMoreLabel.isHidden = true
            }
        }

        self.imageListViewModel.showLoadMore = {
            DispatchQueue.main.async {
                self.loadingMoreLabel.isHidden = false
            }
        }
    }
    
    func updateDataSource(){
        self.dataSource = ImageListTableViewDataSource(cellIdentifier: "ImageListCell", items: self.imageListViewModel.imageListData.value, loadCell: { (cell, imgData) in
            cell.item = imgData
            cell.imageTitle.text = imgData.imageTitle
        })
        
        DispatchQueue.main.async {
            self.imageListTableView.dataSource = self.dataSource
            self.imageListTableView.reloadData()
        }
    }
    
    
}
extension SearchViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((imageListTableView.contentOffset.y + imageListTableView.frame.size.height + 6) >= imageListTableView.contentSize.height)
        {
            imageListViewModel.fetchMore()
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        imageListViewModel.fetchImages(searchBar.text)
    }
}
