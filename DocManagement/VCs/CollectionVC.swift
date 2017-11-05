//
//  CollectionVC.swift
//  DocManagement
//
//  Created by Melody on 11/3/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
//    var collection: Collection!
    var zippedURL: URL!
    var images = [URL]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        let url = zippedURL.absoluteString
        let imagesURL = zippedURL.lastPathComponent
        let endIndex = imagesURL.index(imagesURL.endIndex, offsetBy: -4)
        let col_name = imagesURL[..<endIndex]
        
         let path = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(col_name)")
        
        let contents = try? FileManager.default.contentsOfDirectory(at: path!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        if let contents = contents {
            //filter the extension of each image url ($0)
            images = contents.filter({ $0.absoluteString.contains(".jpg") || $0.absoluteString.contains(".jpeg")})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! PictureCell
        let image = images[indexPath.row]
        
        cell.pictureImageView?.image = UIImage(contentsOfFile: image.absoluteURL.relativePath)

        return cell
    }
    
    
}


