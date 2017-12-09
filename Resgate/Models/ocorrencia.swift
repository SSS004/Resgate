//
//  ocorrencia.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit

class Ocorrencia {

  public var inicializado: Int
  public var socorrista: String
  public var dataOcorrencia: Date
  public var dataFimOcorrencia: Date
  public var condicaoFinal: String   // "Nao Informado", Estavel, Grave ou Obito
  public var Endereco: EnderecoMapa
  public var identificacao: IdentificacaoBeneficiario
  public var imagensFotos: [UmaFoto]
  public var tipoTrauma: TipoTrauma
  public var informacaoClinica: InformacaoClinica
  public var operadora: OperadoraSaude
  public var hospital: Hospital
  
  
  init() {
    
    self.inicializado = 0
    self.socorrista  = ""
    self.dataOcorrencia = Date()
    self.dataFimOcorrencia = Date()
    self.condicaoFinal = "Nao Informado"
    self.Endereco = EnderecoMapa()
    self.identificacao = IdentificacaoBeneficiario()
    self.tipoTrauma = TipoTrauma()
    self.informacaoClinica = InformacaoClinica()
    self.operadora = OperadoraSaude()
    self.hospital = Hospital()
    self.imagensFotos = []
    
  }
  
}
