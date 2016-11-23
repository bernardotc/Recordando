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
    @IBOutlet weak var barBtnNext: UIBarButtonItem!
    
    var categories: [Categoria] = []
    var generalCategory: Categoria!
    var images: [Imagen] = []
    var correctImage: Imagen!
    var btnCorrectAnswer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select the categories that are set to be used.
        if !categorias[0].usar {
            for category in categorias {
                if (category.usar) {
                    categories.append(category)
                }
            }
        } else {
            categories = categorias
        }
        
        viewContainer.isHidden = true
        lblInstruction.text = "Selecciona la imagen que no va de acuerdo con las otras tres."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadImages()
    }
    
    // Main function controller of the process of showing images
    func loadImages() {
        barBtnNext.isEnabled = false
        generalCategory = selectCategory()
        selectThreeImagesFromSameCategory(category: generalCategory)
        getImageFromDifferentCategory()
        images.shuffle()
        setImages()
    }
    
    // Select the category of the iteration.
    func selectCategory() -> Categoria {
        let categoryCount = categories.count
        while true {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
            // Make sure the category has at least 3 different images.
            if categories[random].imagenes.count >= 3 {
                return categories[random]
            }
        }
    }
    
    // From the category selected for this iteration, select 3 images.
    func selectThreeImagesFromSameCategory(category: Categoria) {
        let imageCount = category.imagenes.count
        var threeRandomNumbers: [Int] = []
        // Be sure that there are 3 different images.
        while threeRandomNumbers.count < 3 {
            let random = Int(arc4random_uniform(UInt32(imageCount)))
            if !threeRandomNumbers.contains(random) {
                threeRandomNumbers.append(random)
                images.append(category.imagenes[random])
            }
        }
    }
    
    // Set the image that is from a different category
    func getImageFromDifferentCategory() {
        let categoryCount = categories.count
        while images.count < 4 {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
            // Check that the category has at least 1 image.
            if categories[random].imagenes.count >= 1 {
                if categories[random].id != generalCategory.id {
                    let index = Int(arc4random_uniform(UInt32(categories[random].imagenes.count)))
                    correctImage = categories[random].imagenes[index]
                    images.append(correctImage)
                }
            }
        }
    }
    
    // Put the images to their respective outlets.
    func setImages() {
        btnLeftTopAnswer.setImage(images[0].image, for: .normal)
        btnRightTopAnswer.setImage(images[1].image, for: .normal)
        btnLeftBottomAnswer.setImage(images[2].image, for: .normal)
        btnRightBottomAnswer.setImage(images[3].image, for: .normal)
        
        if correctImage.id == images[0].id {
            btnCorrectAnswer = btnLeftTopAnswer
        } else if correctImage.id == images[1].id {
            btnCorrectAnswer = btnRightTopAnswer
        } else if correctImage.id == images[2].id {
            btnCorrectAnswer = btnLeftBottomAnswer
        } else {
            btnCorrectAnswer = btnRightBottomAnswer
        }
    }
    
    // When a user does a tap to an image, this method is called.
    @IBAction func chooseAnswer(_ sender: UIButton) {
        barBtnNext.isEnabled = true
        viewContainer.isHidden = false
        lblInstruction.isHidden = true
        btnLeftTopAnswer.alpha = 0.4
        btnRightTopAnswer.alpha = 0.4
        btnLeftBottomAnswer.alpha = 0.4
        btnRightBottomAnswer.alpha = 0.4
        if (sender == btnCorrectAnswer) {
            lblIsCorrect.text = "¡Correcto!"
        } else {
            lblIsCorrect.text = "Incorrecto."
        }
        lblCategory.text = "Categoría: \(generalCategory.nombre!)."
    }
    
    // When the next button is clicked.
    @IBAction func showNextSet(_ sender: AnyObject) {
        viewContainer.isHidden = true
        images = []
        loadImages()
        lblInstruction.isHidden = false
        btnLeftTopAnswer.alpha = 1
        btnRightTopAnswer.alpha = 1
        btnLeftBottomAnswer.alpha = 1
        btnRightBottomAnswer.alpha = 1
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Show image info
        if segue.identifier == "popoverImageInfo" {
            let view = segue.destination as! ImageInformationViewController
            
            let button = sender as! UIButton
            
            // Check what was the image that made the call
            if button == btnLeftTopInfo {
                view.imageDescription = images[0].descripcion
            } else if button == btnRightTopInfo {
                view.imageDescription = images[1].descripcion
            } else if button == btnLeftBottomInfo {
                view.imageDescription = images[2].descripcion
            } else {
                view.imageDescription = images[3].descripcion
            }
            
            // Show popover
            view.modalPresentationStyle = .popover
            view.popoverPresentationController?.delegate = self
        }
    }
    
    // Be sure the popover adapts.
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

// An extension to make the images shuffle.
extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
