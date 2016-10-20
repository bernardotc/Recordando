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
        imgViewTopLeft.image = UIImage(data: NSData(contentsOf: NSURL(string: "http://m.rgbimg.com/cache1vH5an/users/o/op/openbox/600/oncTl1E.jpg") as! URL) as! Data)
        imgViewTopRight.image = UIImage(data: NSData(contentsOf: NSURL(string: "http://wall--art.com/wp-content/uploads/2014/05/caribbean_beach_wallpaper_hd_by_venomxbaby-d6qssfc.jpg") as! URL) as! Data)
        imgViewBottomLeft.image = UIImage(data: NSData(contentsOf: NSURL(string: "http://m.rgbimg.com/cache1p4Bwh/users/z/ze/zela/600/mEqh9i8.jpg") as! URL) as! Data)
        imgViewBottomRight.image = UIImage(data: NSData(contentsOf: NSURL(string: "http://images.all-free-download.com/images/graphicthumb/tropical_beach_in_barbados_204380.jpg") as! URL) as! Data)
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
