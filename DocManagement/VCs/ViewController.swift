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
    
    var collection = [Collections]()

    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.shared.getCollection() { (data) in
            let list = try? JSONDecoder().decode([Collections].self, from: data)
            print(list)
            self.collection = list!
            
        }
        

//        Downloader.load(url: , to: <#T##URL#>, completion: <#T##() -> ()#>)

//        do {
//            let filePath = Bundle.main.url(forResource: "file", withExtension: "zip")!
//            let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
//            try Zip.unzipFile(filePath, destination: documentsDirectory, overwrite: true, password: "password", progress: { (progress) -> () in
//                print(progress)
//            }) // Unzip
//
//        }
//        catch {
//            print("Something went wrong")
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

