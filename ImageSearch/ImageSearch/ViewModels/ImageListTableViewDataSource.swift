//
//  ImageListTableViewDataSource.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import UIKit
class ImageListTableViewDataSource<C : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var loadCell : (C, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], loadCell : @escaping (C, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.loadCell = loadCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! C
        
        let item = self.items[indexPath.row]
        self.loadCell(cell, item)
        return cell
    }
}
