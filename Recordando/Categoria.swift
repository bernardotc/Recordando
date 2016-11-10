//
//  Categoria.swift
//  Recordando
//
//  Created by Daniel Guerra on 10/19/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import Foundation

class Categoria {
    
    var id: Int?
    var nombre: String?
    var imagenes: [Imagen] = []
    var usar: Bool = true
    
    init(id: Int, nombre: String) {
        self.id = id
        self.nombre = nombre
    }
    
}
