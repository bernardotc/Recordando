//
//  Imagen.swift
//  Recordando
//
//  Created by Daniel Guerra on 10/19/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import Foundation
import UIKit

class Imagen {
    
    var id: Int?
    var fileName: String?
    var descripcion: String?
    var image: UIImage?
    
    init(id: Int, fileName: String, descripcion: String) {
        self.id = id
        self.fileName = fileName
        self.descripcion = descripcion
        
        if let url = NSURL(string: "http://35.160.114.150/recordando/img/\(fileName).jpg"), let data = NSData(contentsOf: url as URL), let image = UIImage(data: data as Data) {
            self.image = image
        }
    }
    
}
