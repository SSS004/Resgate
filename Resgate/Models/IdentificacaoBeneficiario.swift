//
//  IdentificacaoBeneficiario.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class IdentificacaoBeneficiario {
  
  public var nomeCompleto: String
  public var dataNasc: Date
  public var nomeMae: String
  public var sexo: String
  public var cpf: String
  public var rg: String
  public var carteirinha: String
  public var operadora: String
  
  init() {
     nomeCompleto = ""
     dataNasc = Date()
     nomeMae = ""
     sexo = "I"
     cpf = ""
     rg = ""
     carteirinha = ""
     operadora = ""
  }
  
}
