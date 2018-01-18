//
//  ViewController.swift
//  realmExample
//
//  Created by Jorge MR on 17/01/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var promedioTextField: UITextField!
    @IBOutlet weak var matItalianoSwitch: UISwitch!
    @IBOutlet weak var matFrancesSwitch: UISwitch!
    
    @IBOutlet weak var resultadosTextView: UITextView!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func guardar(_ sender: UIButton) {
        if nombreTextField.text != "" && promedioTextField.text != "" {
            let nombre = nombreTextField.text!
            guard let promedio = Double(promedioTextField.text!) else { return }
            let materias : List<MateriaRealm> = List<MateriaRealm>()
            if matItalianoSwitch.isOn {
                let italiano = MateriaRealm()
                italiano.nombre = "italiano"
                italiano.creditos = 100
                materias.append(italiano)
            }
            if matFrancesSwitch.isOn{
                let frances = MateriaRealm()
                frances.nombre = "frances"
                frances.creditos = 105
                materias.append(frances)
            }
            let alumno = AlumnoRealm()
            alumno.nombre = nombre
            alumno.promedio = promedio
            alumno.materias = materias
            try! realm.write {
                realm.add(alumno)
            }
            print(alumno)
        }
        
        
        
    }
    
    @IBAction func filtrarPorNombre(_ sender: UIButton) {
//        if nombreTextField.text != "" {
//            let nombre = nombreTextField.text!
//            let alumnoQuery = realm.objects(AlumnoRealm.self).filter("nombre == %@",nombre).first
//            guard let alumno = alumnoQuery else { return }
//            var texto = ""
//            texto = texto + "nombre: \(alumno.nombre) \n"
//            texto = texto + "promedio: \(alumno.promedio) \n"
//            for materia in (alumno.materias) {
//                texto = texto + "materia: \(materia.nombre) \n"
//            }
//            resultadosTextView.text = texto
//        }
        if nombreTextField.text != "" {
            let nombre = nombreTextField.text!
            let alumnosQuery = realm.objects(AlumnoRealm.self).filter("nombre == %@",nombre)
            var texto = ""
            for alumno in alumnosQuery {
                texto = texto + "nombre: \(alumno.nombre) \n"
                texto = texto + "promedio: \(alumno.promedio) \n"
                for materia in (alumno.materias) {
                    texto = texto + "materia: \(materia.nombre) \n"
                }
            }
            resultadosTextView.text = texto
        }
    }
    
    @IBAction func filtrarPorPromedio(_ sender: UIButton) {
        if promedioTextField.text != "" {
            guard let promedio = Double(promedioTextField.text!) else { return }
            let alumnos = realm.objects(AlumnoRealm.self).filter("promedio > %@",promedio)
            var text = ""
            for alumno in alumnos {
                text = text + "\(alumno.nombre) \n"
            }
            resultadosTextView.text = text
        }
    }
    
    @IBAction func filtrarPorMateria(_ sender: UIButton) {
        let alumnos = realm.objects(AlumnoRealm.self).filter("ANY materias.nombre == %@", "italiano")
        var text = ""
        for alumno in alumnos {
            text = text + "\(alumno.nombre) \n"
        }
        resultadosTextView.text = text
    }
    
}

