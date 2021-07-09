//
//  NewsByCategoryCell.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/6/21.
//

import UIKit

class NewsByCategoryCell: UITableViewCell {
    
    @IBOutlet weak var imageHeader      : UIImageView!
    @IBOutlet weak var newsCount        : UILabel!
    @IBOutlet weak var title            : UILabel!
    @IBOutlet weak var timepost         : UILabel!
    @IBOutlet weak var newsimage        : UIImageView!
    @IBOutlet weak var newsdescription  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item : Item,position:Int){
        guard  let descrip = item.description else {
            print("descrip nil")
            return
        }
        let imglink     = XMLRequest.getImgHtml(data: descrip)
        let description = XMLRequest.getDescription(data: descrip)
        let hour        = convertDateToHour(pubDate: item.pubDate)
  
        if position != 1 {
             XMLRequest.downloadImage(url: imglink, completion: { data in
                DispatchQueue.main.async {
                    self.newsimage.image = UIImage(data: data)
                    self.imageHeader.isHidden = true
                }
            })
        }
        else{
            XMLRequest.downloadImage(url: imglink, completion: { data in
               DispatchQueue.main.async {
                    self.imageHeader.image = UIImage(data: data)
                    self.newsimage.isHidden = true
               }
           })

        }
        DispatchQueue.main.async {
            self.newsCount.text = "\(position)."
            self.title.text = item.title
            self.timepost.text = "\(hour) giờ trước"
            self.newsdescription.text = description
        }
    }
    func convertDateToHour(pubDate: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let datePub = dateFormatter.date(from: pubDate)
        guard let newsDate = datePub else{
            return -1
        }
        let time = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - newsDate.timeIntervalSince1970)
        let hour = time.get(.hour)
        return hour
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
