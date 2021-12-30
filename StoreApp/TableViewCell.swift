//
//  TableViewCell.swift
//  StoreApp
//
//  Created by Jemi on 25/11/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    func initData(item:Items) {
        categoryName.text = item.toCategory?.name
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/DD/yy h:mm a"
        date.text = dateFormat.string(from: item.date_add!)
        title.text = item.name
        imageLabel.image = item.image as? UIImage
    }

}
