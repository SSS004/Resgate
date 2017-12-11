//
//  HospitalTableViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class HospitalTableViewController: UITableViewController {
  
  
  //##########################################
  //MARK: Enumerations
  //##########################################
  
  
  //##########################################
  //MARK: Outlet to Objects
  //##########################################
  @IBOutlet weak var hospitalHCDistancia: UILabel!
  @IBOutlet weak var hospitalSirioDistancia: UILabel!
  @IBOutlet weak var hospitalEinsteinDistancia: UILabel!
  
  
  
  //##########################################
  //MARK: Private Properties
  //##########################################
  private var hospitais: [EnderecoMapaDistancia] = []
  
  //##########################################
  //MARK: Properties
  //##########################################
  public var umaOcorrencia: Ocorrencia!

  //##########################################
  //MARK: Private Methods
  //##########################################
  
  
  
  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  
  
  
  //##########################################
  //MARK: Override functions
  //##########################################

    override func viewDidLoad() {
      
      super.viewDidLoad()

      var distanciaKM: Double = 0.0
      var distanciaMetros: Double = 0.0
      var hospitaisAux: [EnderecoMapaDistancia] = []
      

      let hospitalHC = EnderecoMapa.init()
      
      hospitalHC.endereco = "Av. Dr. Enéas de Carvalho Aguiar, 255"
      hospitalHC.localidade = "São Paulo"
      hospitalHC.bairro = "Cerqueira César"
      hospitalHC.estado = "SP"
      hospitalHC.codigoPostal = ""
      hospitalHC.pais = "Brazil"
      hospitalHC.codigoISOPais = "BR"
      hospitalHC.telefone = "(011) 2661-0000"
      hospitalHC.location = CLLocation(latitude: -23.557436, longitude: -46.670030)
 
      distanciaMetros = hospitalHC.location.distance(from: umaOcorrencia.Endereco.location)
      distanciaKM = distanciaMetros / 1000

      let hc = EnderecoMapaDistancia.init(enderecoMapa: hospitalHC, distanciaMapa: distanciaKM)

      hospitaisAux.append(hc)
      
      let hospitalSirioLibanes = EnderecoMapa.init()

      hospitalSirioLibanes.endereco = "Rua Adma Jafet, 115"
      hospitalSirioLibanes.bairro = "Bela Vista"
      hospitalSirioLibanes.localidade = "São Paulo"
      hospitalSirioLibanes.estado = "SP"
      hospitalSirioLibanes.pais = "Brazil"
      hospitalSirioLibanes.codigoPostal = ""
      hospitalSirioLibanes.codigoISOPais = "BR"
      hospitalSirioLibanes.telefone = "(011) 3394-0200"
      hospitalSirioLibanes.location = CLLocation(latitude: -23.557016, longitude: -46.654310)

      distanciaMetros = hospitalSirioLibanes.location.distance(from: umaOcorrencia.Endereco.location)
      distanciaKM = distanciaMetros / 1000
    
      let sirio = EnderecoMapaDistancia.init(enderecoMapa: hospitalSirioLibanes, distanciaMapa: distanciaKM)
      
      hospitaisAux.append(sirio)

      let hospitalAlbertEinstein = EnderecoMapa.init()

      hospitalAlbertEinstein.endereco = "Av. Albert Einstein, 627"
      hospitalAlbertEinstein.bairro = "Morumbi"
      hospitalAlbertEinstein.localidade = "São Paulo"
      hospitalAlbertEinstein.estado = "SP"
      hospitalAlbertEinstein.pais = "Brazil"
      hospitalAlbertEinstein.codigoPostal = ""
      hospitalAlbertEinstein.codigoISOPais = "BR"
      hospitalAlbertEinstein.telefone = "(011) 2151-1233"
      hospitalAlbertEinstein.location = CLLocation(latitude: -23.599275, longitude: -46.714398)
 
      distanciaMetros = hospitalAlbertEinstein.location.distance(from: umaOcorrencia.Endereco.location)
      distanciaKM = distanciaMetros / 1000
      
      let einstein = EnderecoMapaDistancia.init(enderecoMapa: hospitalAlbertEinstein, distanciaMapa: distanciaKM)
      
      hospitaisAux.append(einstein)
      
      hospitais = hospitaisAux.sorted (by: { $0.distancia < $1.distancia })

      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func viewDidAppear(_ animated: Bool) {

    hospitalHCDistancia.text = String(format: "%.1f", arguments: [hospitais[0].distancia]) + " Km"
    hospitalSirioDistancia.text = String(format: "%.1f", arguments: [hospitais[1].distancia]) + " Km"
    hospitalEinsteinDistancia.text = String(format: "%.1f", arguments: [hospitais[2].distancia]) + " Km"
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
  
  

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
