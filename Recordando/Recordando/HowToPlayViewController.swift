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
    
    var generalCategory: Categoria!
    var images: [Imagen] = []
    var correctImage: Imagen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main logic to load images like the game.
        generalCategory = selectCategory()
        selectThreeImagesFromSameCategory(category: generalCategory)
        getImageFromDifferentCategory()
        images.shuffle()
        
        // Set images
        imgViewTopLeft.image = images[0].image
        imgViewTopRight.image = images[1].image
        imgViewBottomLeft.image = images[2].image
        imgViewBottomRight.image = images[3].image

    }
    
    // Select the category of the iteration.
    func selectCategory() -> Categoria {
        let categoryCount = categorias.count
        while true {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
            // Make sure the category has at least 3 different images.
            if categorias[random].imagenes.count >= 3 {
                return categorias[random]
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
        let categoryCount = categorias.count
        while images.count < 4 {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
            // Check that the category has at least 1 image.
            if categorias[random].imagenes.count >= 1 {
                if categorias[random].id != generalCategory.id {
                    let index = Int(arc4random_uniform(UInt32(categorias[random].imagenes.count)))
                    correctImage = categorias[random].imagenes[index]
                    images.append(correctImage)
                }
            }
        }
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
