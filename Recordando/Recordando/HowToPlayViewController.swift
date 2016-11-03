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
        
        generalCategory = selectCategory()
        selectThreeImagesFromSameCategory(category: generalCategory)
        getImageFromDifferentCategory()
        images.shuffle()
        
        imgViewTopLeft.image = images[0].image
        imgViewTopRight.image = images[1].image
        imgViewBottomLeft.image = images[2].image
        imgViewBottomRight.image = images[3].image

    }
    
    func selectCategory() -> Categoria {
        let categoryCount = categorias.count
        while true {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
            if categorias[random].imagenes.count >= 3 {
                return categorias[random]
            }
        }
    }
    
    func selectThreeImagesFromSameCategory(category: Categoria) {
        let imageCount = category.imagenes.count
        var threeRandomNumbers: [Int] = []
        while threeRandomNumbers.count < 3 {
            let random = Int(arc4random_uniform(UInt32(imageCount)))
            if !threeRandomNumbers.contains(random) {
                threeRandomNumbers.append(random)
                images.append(category.imagenes[random])
            }
        }
    }
    
    func getImageFromDifferentCategory() {
        let categoryCount = categorias.count
        while images.count < 4 {
            let random = Int(arc4random_uniform(UInt32(categoryCount)))
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
