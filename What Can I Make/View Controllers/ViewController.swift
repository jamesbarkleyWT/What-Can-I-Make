//
//  ViewController.swift
//  What Can I Make
//
//  Created by James Barkley on 6/23/21.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var splashImage: UIImageView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        getStartedButton.backgroundColor = UIColor.systemPink
        getStartedButton.layer.cornerRadius = 8.0
        overlay.layer.cornerRadius = 8.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
 
}

