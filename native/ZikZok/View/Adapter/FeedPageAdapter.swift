//
//  FeedPageAdapter.swift
//  ZikZok
//
//  Created by temp-4400 on 29/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import UIKit

//class FeedPageAdapter {
//
//    let delegate: PictureListProtocol
//
//    // MARK: - Constructor
//    init(delegate:PictureListProtocol) {
//        self.delegate = delegate
//    }
//}
//
//// MARK: - UICollectionViewDataSource Delegate implementation
//extension FeedPageAdapter: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureListTableViewCell", for: indexPath) as? PictureListTableViewCell else {
//            fatalError("Cell not exists in storyboard")
//        }
//        
//        cell.picture = delegate.getData( at: indexPath )
//        
//        return cell
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return delegate.retrieveNumberOfSections()
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return delegate.retrieveNumberOfItems()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150.0
//    }
//    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        
//        delegate.itemSelected(at: indexPath)
//                
//        return nil
//    }
//}
