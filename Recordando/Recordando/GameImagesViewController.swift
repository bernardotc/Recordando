//
//  GameImagesViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/17/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class GameImagesViewController: UIViewController {

    @IBOutlet weak var viewInfoButtonContainer: UIView!
    @IBOutlet weak var btnLeftTopInfo: UIButton!
    @IBOutlet weak var btnRightTopInfo: UIButton!
    @IBOutlet weak var btnLeftBottomInfo: UIButton!
    @IBOutlet weak var btnRightBottomInfo: UIButton!
    @IBOutlet weak var btnLeftTopAnswer: UIButton!
    @IBOutlet weak var btnRightTopAnswer: UIButton!
    @IBOutlet weak var btnLeftBottomAnswer: UIButton!
    @IBOutlet weak var btnRightBottomAnswer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewInfoButtonContainer.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
