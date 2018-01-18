//
//  ClasesRealm.swift
//  realmExample
//
//  Created by Jorge MR on 17/01/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation
import RealmSwift

class MateriaRealm: Object {
    @objc dynamic var nombre = ""
    @objc dynamic var creditos: Int = 0
}

class AlumnoRealm: Object {
    @objc dynamic var nombre = ""
    @objc dynamic var promedio: Double = 0.0
    var materias = List<MateriaRealm>()
}
