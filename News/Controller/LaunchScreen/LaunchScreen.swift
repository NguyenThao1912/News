//
//  LaunchScreen.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/8/21.
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let shapeLayer = CAShapeLayer()
        let center = view.center
        let circularPath    = UIBezierPath(arcCenter:center , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path     = circularPath.cgPath
        shapeLayer.strokeColor  = UIColor.red.cgColor
        shapeLayer.lineWidth    = 10
        view.layer.addSublayer(shapeLayer)

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
