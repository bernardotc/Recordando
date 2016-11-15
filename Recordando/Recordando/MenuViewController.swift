//
//  MenuViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/17/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindHowToPlay (sender: UIStoryboardSegue) {
        // Nothing to send
    }
    
    @IBAction func unwindAbout (sender: UIStoryboardSegue) {
        // Nothing to send
    }
    
    @IBAction func unwindCategory (sender: UIStoryboardSegue) {
        // Nothing to send
    }
    
    @IBAction func unwindGame (sender: UIStoryboardSegue) {
        // Nothing to send
    }
    
    @IBAction func unwindSettings (sender: UIStoryboardSegue) {
        // Nothing to send
    }
    
    @IBAction func unwindUpload (sender: UIStoryboardSegue) {
        // Nothing to send
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
