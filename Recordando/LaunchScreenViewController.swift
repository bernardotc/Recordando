//
//  LaunchScreenViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 11/10/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLoading.isHidden = true
        activityIndicator.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(loading), userInfo: nil, repeats: false);
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loading() {
        imageView.image = UIImage(named: "Logo_sin_fondo")
        lblLoading.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(goToMenu), userInfo: nil, repeats: false);
    }
    
    func goToMenu() {
        performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
