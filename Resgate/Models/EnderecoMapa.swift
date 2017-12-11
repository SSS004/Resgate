//
//  EnderecoMapa.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit

class EnderecoMapa {

  public var endereco: String
  public var localidade: String
  public var bairro: String
  public var estado: String
  public var codigoPostal: String
  public var pais: String
  public var codigoISOPais: String
  public var telefone: String

  //  placemark.name = endereco
  //  placemark.locality = localidade
  //  placemark.subLocality = bairro
  //  placemark.administrativeArea = estado
  //  placemark.postalCode = codigoPostal
  //  placemark.country = pais
  //  placemark.isoCountryCode = codigoISOPais

  
//  placemark.name = Alameda Araguaia, 847–1051
//  placemark.thoroughfare = Alameda Araguaia
//  placemark.subThoroughfare = 847–1051
//  placemark.subLocality = Alphaville Comercial
//  placemark.locality = Barueri
//  placemark.administrativeArea = SP
//  placemark.postalCode = 06455
//  placemark.country = Brazil
//  placemark.isoCountryCode = BR
  
  public var location: CLLocation

  init() {
    
    self.endereco = ""
    self.localidade = ""
    self.bairro = ""
    self.estado = ""
    self.codigoPostal = ""
    self.pais = ""
    self.codigoISOPais = ""
    self.telefone = ""
    self.location = CLLocation(latitude: 0, longitude: 0)
  }

}

class EnderecoMapaDistancia {
  
  public var endereco: EnderecoMapa!
  public var distancia: Double!
  
  init(enderecoMapa: EnderecoMapa, distanciaMapa: Double) {
    endereco = enderecoMapa
    distancia = distanciaMapa
  }
  
}

