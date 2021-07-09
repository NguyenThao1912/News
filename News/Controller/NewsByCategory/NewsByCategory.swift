//
//  NewsByCategory.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/6/21.
//

import UIKit
import SafariServices
class NewsByCategory: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var category : Section!
    var listNews : [Item] = []
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setUpRefreshControl()
        // Do any additional setup after loading the view.
    }
    func setUI(){
        tableview.delegate = self
        tableview.dataSource = self
        
        let nib = UINib(nibName: "NewsByCategoryCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "SectionCell")
        let nib2  = UINib(nibName: "NewsCategory", bundle: nil)
        tableview.register(nib2, forCellReuseIdentifier: "SectionCellHeader")
        self.title = category.tittle
        tableview.addSubview(refreshControl)
      
  
    }
    

    func setUpRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data")
        if #available(iOS 10.0, *) {
            tableview.refreshControl = refreshControl
            
        } else {
            tableview.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
    }
    @objc private func fetchData(_ sender: Any) {
        // Fetch Weather Data
        setData()
        refreshControl.endRefreshing()
    }
    func setData(){
        let url = category.type.ConstructURL(type: category.type)
        XMLRequest.RequestXML(url: url) { data in
            self.listNews = data
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}
extension NewsByCategory : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! NewsByCategoryCell
        
        let currentElement = listNews[indexPath.row]
  
        if indexPath.row == 0 {
            cell.newsimage.isHidden = true
            cell.imageHeader.isHidden = false
        }
        else{
            cell.newsimage.isHidden = false
            cell.imageHeader.isHidden = true
        }
        
        cell.setData(item:currentElement,position: indexPath.row + 1)
        return cell
         
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listNews.count 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = listNews[indexPath.row].link else {
            return
        }
        if let url = URL(string: urlString) {
          let safariVC = SFSafariViewController(url: url)
          self.present(safariVC, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
