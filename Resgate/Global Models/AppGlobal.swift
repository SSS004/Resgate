//
//  AppGlobal.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 01/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit

struct appVariables {
  static var salvarUsuario: Bool = false

}


public func atualizarUserDefaults(salvarUsuario salvar: Bool, emailAddress email: String) {
  
  if (salvar) {
    
    // Não existe, cria o padrão que será salvar usuario
    UserDefaults.standard.set(true, forKey: "salvarUsuario")
    UserDefaults.standard.set(email, forKey: "enderecoEmail")
    appVariables.salvarUsuario = true
    
  } else {
    
    UserDefaults.standard.set(false, forKey: "salvarUsuario")
    UserDefaults.standard.removeObject(forKey: "enderecoEmail")
    appVariables.salvarUsuario = false
    
  }
  
}
