//
//  GameImagesViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/17/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class GameImagesViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnLeftTopInfo: UIButton!
    @IBOutlet weak var btnRightTopInfo: UIButton!
    @IBOutlet weak var btnLeftBottomInfo: UIButton!
    @IBOutlet weak var btnRightBottomInfo: UIButton!
    @IBOutlet weak var btnLeftTopAnswer: UIButton!
    @IBOutlet weak var btnRightTopAnswer: UIButton!
    @IBOutlet weak var btnLeftBottomAnswer: UIButton!
    @IBOutlet weak var btnRightBottomAnswer: UIButton!
    @IBOutlet weak var lblIsCorrect: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    
    // TODO: Array or dictionary of images
    
    var btnCorrectAnswer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewContainer.isHidden = true
        lblInstruction.text = "Selecciona la imagen que no va de acuerdo con las otras tres."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadImages()
    }
    
    func loadImages() {
        // TODO : get URL from database
        //        btnLeftTopAnswer.setImage(UIImage(data: NSData(contentsOf: NSURL(string: "http://m.rgbimg.com/cache1vH5an/users/o/op/openbox/600/oncTl1E.jpg") as! URL) as! Data), for: .normal)
        //        btnRightTopAnswer.setImage(UIImage(data: NSData(contentsOf: NSURL(string: "http://wall--art.com/wp-content/uploads/2014/05/caribbean_beach_wallpaper_hd_by_venomxbaby-d6qssfc.jpg") as! URL) as! Data), for: .normal)
        //        btnLeftBottomAnswer.setImage(UIImage(data: NSData(contentsOf: NSURL(string: "http://m.rgbimg.com/cache1p4Bwh/users/z/ze/zela/600/mEqh9i8.jpg") as! URL) as! Data), for: .normal)
        //        btnRightBottomAnswer.setImage(UIImage(data: NSData(contentsOf: NSURL(string: "http://images.all-free-download.com/images/graphicthumb/tropical_beach_in_barbados_204380.jpg") as! URL) as! Data), for: .normal)
        
        let category = categorias[0]
        
        self.btnLeftTopAnswer.setImage(category.imagenes[0].image, for: .normal)
        self.btnRightTopAnswer.setImage(category.imagenes[1].image, for: .normal)
        self.btnLeftBottomAnswer.setImage(category.imagenes[2].image, for: .normal)
        self.btnRightBottomAnswer.setImage(category.imagenes[3].image, for: .normal)
        
        btnCorrectAnswer = btnLeftBottomAnswer
    }
    
    @IBAction func chooseAnswer(_ sender: UIButton) {
        viewContainer.isHidden = false
        lblInstruction.isHidden = true
        btnLeftTopAnswer.alpha = 0.4
        btnRightTopAnswer.alpha = 0.4
        btnLeftBottomAnswer.alpha = 0.4
        btnRightBottomAnswer.alpha = 0.4
        if (sender == btnCorrectAnswer) {
            lblIsCorrect.text = "Correcto!"
        } else {
            lblIsCorrect.text = "Incorrecto!"
        }
        lblCategory.text = "La categoría era: Playa."
    }
    
    @IBAction func showNextSet(_ sender: AnyObject) {
        // TODO!
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverImageInfo" {
            let view = segue.destination as! ImageInformationViewController
            
            let button = sender as! UIButton
            
            if button == btnLeftTopInfo {
                view.imageDescription = "Esta es la foto de la playa que tome ayer."
            } else if button == btnRightTopInfo {
                view.imageDescription = "Recuerdo que la playa de Cancún es de las mejores. Se le conoce como una de las mejores playas del mundo."
            } else if button == btnLeftBottomInfo {
                view.imageDescription = "El bosque del Amazones se ubica Brasil y tiene una flora y fauna muy variada."
            } else {
                view.imageDescription = "En el mar, la vida es más sabrosa."
            }
            
            view.modalPresentationStyle = .popover
            view.popoverPresentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
