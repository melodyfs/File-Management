//
//  ViewController.swift
//  DocManagement
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Zip


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collections = [Collection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Networking.shared.getCollection() { (data) in
            let list = try? JSONDecoder().decode([Collection].self, from: data)
            self.collections = list!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
}

extension ViewController: CollectionCellDelegate {
    func loadImage(_ collection: Collection, _ sender: CollectionCell) {
        DownloadFile.shared.load(url: collection.zipped_images_url) { url in
            let fileExist = FileManager.default.fileExists(atPath: "\(url.absoluteString)/")

            if fileExist {
                print("Downloaded already")
            }

            let fileURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(collection.collection_name.lowercased())/_preview.png")
            
            DispatchQueue.main.async {
                guard let imageURL = fileURL?.path else {return}
                sender.imageView?.image = UIImage(contentsOfFile: imageURL)
            }
        }
            
        }
    
    
}




