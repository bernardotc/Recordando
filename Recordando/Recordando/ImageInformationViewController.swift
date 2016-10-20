//
//  ImageInformationViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/19/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class ImageInformationViewController: UIViewController {
    
    @IBOutlet weak var lblDescription: UILabel!
    
    var imageDescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblDescription.text = imageDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
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
