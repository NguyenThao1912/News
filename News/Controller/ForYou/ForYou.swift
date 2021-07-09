//
//  ForYou.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/9/21.
//

import UIKit

class ForYou: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
         let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
         left.direction = .left
         self.view.addGestureRecognizer(left)

         let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
         right.direction = .right
         self.view.addGestureRecognizer(right)
        print("For You")
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
