//
//  CollectionVC.swift
//  DocManagement
//
//  Created by Melody on 11/3/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    var collection: Collection!
//    var unzippedURL: URL!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let zippedURL = collection.zipped_images_url
//        let url = URL(string: zippedURL)!
        let imagesURL = zippedURL.lastPathComponent
        print(imagesURL)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! PictureCell
        

        return cell
    }
    
    
}


