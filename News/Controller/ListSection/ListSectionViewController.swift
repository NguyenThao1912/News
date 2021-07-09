//
//  ListSectionViewController.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/6/21.
//

import UIKit

class ListSectionViewController: UIViewController {

    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI()  {
        
        self.title = "List Section"
        tableview.delegate = self
        tableview.dataSource = self
        
        let nib = UINib(nibName: "SectionCellTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "Section")
        
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListSectionViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Section", for: indexPath) as! SectionCellTableViewCell
        cell.title.text = SectionManager.data[indexPath.row].tittle
        cell.logo.image = UIImage(named: SectionManager.data[indexPath.row].image)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionManager.data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            tabBarController!.selectedIndex = 0
        }
        else{
            let vc = NewsByCategory()
            vc.category = SectionManager.data[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
