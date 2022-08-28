//
//  SplashScreenVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/28/22.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        let transition = CATransition()
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 1
        nameLabel.layer.add(transition, forKey: nil)
        nameLabel.text = "\t\t\t\tU"
        nameLabel.textAlignment = .left
        
        animationView = .init(name:"coins")
        animationView?.frame = CGRect(x: nameLabel.center.x - 10 , y: 320, width: 120, height: 130)
        animationView?.animationSpeed = 0.7
        
       
        
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (_) in
            self.animationView?.play()
            self.view.addSubview(self.animationView!)
        }
        Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) { (_) in
       
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }
        
    }

}
