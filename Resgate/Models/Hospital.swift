//
//  Hospital.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class Hospital {
  
  public var idHospital: String
  public var nomeHospital: String
  public var enderecoHospital: EnderecoMapa
  
  init() {
    idHospital = ""
    nomeHospital = ""
    enderecoHospital = EnderecoMapa()
  }
  
}

