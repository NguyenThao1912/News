//
//  ViewController.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/5/21.
//

import UIKit
import SafariServices
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let tabbarController  = UITabBarController()
    var newsItem  : [Item] = []
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUI()
        setData()
        setUpRefreshControl()
    }

    func setUI()  {
        self.title = "VN EXPRESS"
      
        let nibcell = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nibcell, forCellReuseIdentifier: "NewsCell")
        tableView.dataSource = self
        tableView.delegate  = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .done, target: self, action: #selector(fetchData))
       
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)

        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)
    }
    @objc func swipeLeft() {
            let total = self.tabBarController!.viewControllers!.count - 1
            tabBarController!.selectedIndex = min(total, tabBarController!.selectedIndex + 1)

    }

    @objc func swipeRight() {
            tabBarController!.selectedIndex = max(0, tabBarController!.selectedIndex - 1)
    }
    func setUpRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data")
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
    }
    func setData() {
        print("Loading data ")
        XMLRequest.RequestXML(url: Constants.Home.ConstructURL(type: .Home)) { data in
            self.newsItem = data
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
   
    @objc private func fetchData(_ sender: Any) {
        // Fetch Weather Data
        setData()
        refreshControl.endRefreshing()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
            }, completion: nil)
        }
        else{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.setToolbarHidden(false, animated: true)
            }, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setData(item: newsItem[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItem.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = newsItem[indexPath.row].link else {
            return
        }
        if let url = URL(string: urlString) {
          let safariVC = SFSafariViewController(url: url)
          self.present(safariVC, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    
}

