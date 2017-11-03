//
//  CollectionCell.swift
//  DocManagement
//
//  Created by Melody on 11/2/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func loadImage(_ collection: Collection, _ sender: CollectionCell)
}

class CollectionCell: UITableViewCell {
    
    var collection: Collection!

    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    weak var delegate: CollectionCellDelegate?
    
    
    @IBAction func loadButton(_ sender: UIButton) {
        delegate?.loadImage(collection, self)

    }
    
    func configureCell(collection: Collection){
        self.collection = collection
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
