//
//  NewsCell.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/7/21.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsimage: UIImageView!
    @IBOutlet weak var newsdescrip: UILabel!
    @IBOutlet weak var newsSection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item: Item){
        guard let descriptionNews = item.description else { return  }
        let imglink     = XMLRequest.getImgHtml(data: descriptionNews)
        let descrip     = XMLRequest.getDescription(data: descriptionNews)
        XMLRequest.downloadImage(url: imglink) { data in
            DispatchQueue.main.async {
                self.newsimage.image = UIImage(data: data)
            }
        }

        DispatchQueue.main.async {
            self.title.text = item.title
            self.newsdescrip.text = descrip
            self.newsSection.text    = "Tin mới nhất"
        }

    }
    
}
