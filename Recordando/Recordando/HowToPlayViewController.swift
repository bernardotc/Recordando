//
//  HowToPlayViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/19/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {

    @IBOutlet weak var imgViewTopLeft: UIImageView!
    @IBOutlet weak var imgViewTopRight: UIImageView!
    @IBOutlet weak var imgViewBottomLeft: UIImageView!
    @IBOutlet weak var imgViewBottomRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category = categorias[0]
        
        imgViewTopLeft.image = category.imagenes[0].image
        imgViewTopRight.image = category.imagenes[1].image
        imgViewBottomLeft.image = category.imagenes[2].image
        imgViewBottomRight.image = category.imagenes[3].image

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
