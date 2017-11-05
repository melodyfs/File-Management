//
//  ViewController.swift
//  DocManagement
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Zip


class PreviewVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collections = [Collection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Networking.shared.getCollection() { (data) in
            let list = try? JSONDecoder().decode([Collection].self, from: data)
            self.collections = list!
            print(list)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collections = list!

            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

extension PreviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        let collection = collections[indexPath.row]
        
        cell.collectionNameLabel.text = collection.collection_name
        cell.delegate = self
        cell.configureCell(collection: collection)
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = collections[indexPath.row]
        
        let collectionVC = self.storyboard?.instantiateViewController(withIdentifier: "collectionVC") as! CollectionVC
        collectionVC.zippedURL = collection.zipped_images_url
        self.present(collectionVC, animated: false, completion: nil)

    }
}

extension PreviewVC: CollectionCellDelegate {
    func loadImage(_ collection: Collection, _ sender: CollectionCell) {
        DownloadFile.shared.load(url: collection.zipped_images_url) { url in
            
            let image_url = collection.zipped_images_url.absoluteString
            let startIndex = image_url.index(image_url.startIndex, offsetBy: 40)
            let endIndex = image_url.index(image_url.endIndex, offsetBy: -4)
            let col_name = image_url[startIndex..<endIndex]
            

            let fileURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(col_name)/_preview.png")

            DispatchQueue.main.async {
                guard let imageURL = fileURL?.path else {return}
                sender.imageView?.image = UIImage(contentsOfFile: imageURL)
                self.tableView.reloadData()
                
            }
        }
            
    }
    
    
}




