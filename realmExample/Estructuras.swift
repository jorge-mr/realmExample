//
//  Estructuras.swift
//  realmExample
//
//  Created by Jorge MR on 17/01/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

struct Materia {
    var nombre : String
    var creditos : Int
}

struct Alumno {
    var nombre : String
    var promedio : Double
    var materias : [Materia]
}
