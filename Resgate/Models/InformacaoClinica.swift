//
//  InformacaoClinica.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class InformacaoClinica {
  
  public var glasgow: Int
  public var pressaoArterialSistolica: Int
  public var pressaoArterialDiastolica: Int
  public var freqRespiratoria: Int
  public var oxigenacao: Int
  public var tempoRetiradaVitima: Int
  public var tipoRemocao: String  // AEREA ou TERRESTRE
  public var Inconciente: String  // SIM ou NAO
  
  init() {
    glasgow = 0
    pressaoArterialSistolica = 0
    pressaoArterialDiastolica = 0
    freqRespiratoria = 0
    oxigenacao = 0
    tempoRetiradaVitima = 0
    tipoRemocao = "TERRESTRE"
    Inconciente = "SIM"
  }
}


