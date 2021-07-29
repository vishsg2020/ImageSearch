//
//  ImageListViewModel.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation
class ImageListViewModel : NSObject {
    
    private var currentPage: Int = 0
    private var searchKeyWord: String = "sample"
    private var apiService : SearchService!
    private var isDataLoading = false
    private(set) var imageListData : ImageListModel! {
        didSet {
            self.isDataLoading = false
            self.bindImageListViewModel()
        }
    }
    
    var bindImageListViewModel : (() -> ()) = {}
    var showLoader : (() -> ()) = {}
    var hideLoader : (() -> ()) = {}
    var showLoadMore : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  SearchService()
    }
    
    func fetchMore() {
        self.showLoadMore()
        fetchImages(nil)
    }
    func fetchImages(_ searchKey: String?) {
        if isDataLoading || searchKey == searchKeyWord {
            return
        }
        setSearchKeyWord(searchKey)
        guard let requestString = prepareRequest(searchKeyWord) else {
            clearResults()
            return
        }
        isDataLoading = true
        fetchImageList(requestString)
    }
    private func fetchImageList(_ requestString: String) {
        self.apiService.fetchImageList(urlParamString: requestString) { (imageListData) in
            self.hideLoader()
            if let newData = imageListData, self.imageListData != nil {
                self.imageListData.value.append(contentsOf: newData.value)
            } else {
                self.imageListData = imageListData
            }
        }
    }
}
extension ImageListViewModel {
    private func setSearchKeyWord(_ searchKey: String?) {
        if let key = searchKey, key != searchKeyWord {
            searchKeyWord = key
            clearResults()
            self.showLoader()
        }
    }
    private func clearResults() {
        currentPage = 0
        if self.imageListData != nil {
        self.imageListData.clear()
        }
    }
}
extension ImageListViewModel {
    private func prepareRequest(_ searchKey: String?) -> String? {
        guard let requestParam = configureSearchRequestParam(searchKey) else { return nil }
        let requestString = "q=\(requestParam.searchKey)&pageNumber=\(requestParam.pageNumber)&pageSize=\(requestParam.pageSize)&autoCorrect=\(requestParam.autoCurrect.toString())"
        return requestString
    }
    private func configureSearchRequestParam(_ searchKey: String?) -> SearchRequestParam? {
        guard let searchKey = searchKey else { return nil }
        currentPage += 1
        return SearchRequestParam(searchKey: searchKey, pageNumber: currentPage)
    }
}
