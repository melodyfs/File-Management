//
//  Downloader.swift
//  DocManagement
//
//  Created by Melody on 11/1/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import Zip

class DownloadFile {
    
    static var shared = DownloadFile()
    
    func load(url: URL, completion: @escaping (URL) -> (Void)) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                
                let cachesDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                Zip.addCustomFileExtension("tmp")
                
                try? Zip.unzipFile(tempLocalUrl, destination: cachesDir, overwrite: true, password: nil, progress: { (progress) -> () in
                    print(progress)
                    print("Download file")
                    completion(cachesDir)

                })
            } else {
                print("Failure: %@", error?.localizedDescription);
            }
        }
        task.resume()

    }
}
