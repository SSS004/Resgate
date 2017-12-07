//
//  TipoTraumaTableViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class TipoTraumaTableViewController: UITableViewController {

  //##########################################
  //MARK: Enumerations
  //##########################################
  private enum sectionIndex: Int {
    case tipoTraumaSection = 0
    case traumaSection = 1
  }
  
  private enum rowIndexAtTipoTraumaSection: Int {
    case tipoPolitraumatismo = 0
    case tipoTraumatismo = 1
    case tipoAfogamento = 2
    case tipoArmaBranca = 3
    case tipoArmaDeFogo = 4
    case tipoQueimadura = 5
    case tipoEnvenenamento = 6
    
  }
  
  private enum rowIndexAtTraumaSection: Int {
    case traumaCranioFacial = 0
    case traumaTorax = 1
    case traumaBaciaPelve = 2
    case traumaRaquimedular = 3
    case traumaAbdomen = 4
    case traumaMM_SS = 5
    case traumaMM_II = 6
  }
  
  
  //##########################################
  //MARK: Outlet to Objects
  //##########################################
  @IBOutlet weak var swtPolitraumatismo: UISwitch!
  @IBOutlet weak var swtTraumatismo: UISwitch!
  @IBOutlet weak var swtAfogamento: UISwitch!
  @IBOutlet weak var swtArmaBranca: UISwitch!
  @IBOutlet weak var swtArmaDeFogo: UISwitch!
  @IBOutlet weak var swtQueimadura: UISwitch!
  @IBOutlet weak var swtEnvenenamento: UISwitch!
  

  @IBOutlet weak var swtTraumaCranioFacial: UISwitch!
  @IBOutlet weak var swtTraumaTorax: UISwitch!
  @IBOutlet weak var swtTraumaBaciaPelve: UISwitch!
  @IBOutlet weak var swtTraumaRaquimedular: UISwitch!
  @IBOutlet weak var swtTraumaAbdomen: UISwitch!
  @IBOutlet weak var swtTraumaMM_SS: UISwitch!
  @IBOutlet weak var swtTraumaMM_II: UISwitch!
  
  
  
  
  
  //##########################################
  //MARK: Properties
  //##########################################
  var umaOcorrencia: Ocorrencia!
  
  
  //##########################################
  //MARK: Private Methods
  //##########################################
  private var tipoTrauma: TipoTrauma!
  
  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func bbiChamarCallCenter(_ sender: UIBarButtonItem) {
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
  }
  
  
  
  //##########################################
  //MARK: Override functions
  //##########################################
  
  

  override func viewDidLoad() {
        super.viewDidLoad()
    
      self.tipoTrauma = umaOcorrencia.tipoTrauma

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  
  override func viewWillAppear(_ animated: Bool) {
    
    swtPolitraumatismo.isOn = tipoTrauma.tipoPolitraumatismo
    swtTraumatismo.isOn = tipoTrauma.tipoTraumatismo
    swtAfogamento.isOn = tipoTrauma.tipoAfogamento
    swtArmaBranca.isOn = tipoTrauma.tipoArmaBranca
    swtArmaDeFogo.isOn = tipoTrauma.tipoArmaDeFogo
    swtQueimadura.isOn = tipoTrauma.tipoQueimadura
    swtEnvenenamento.isOn = tipoTrauma.tipoEnvenenamento
    
    swtTraumaCranioFacial.isOn = tipoTrauma.traumaCranioFacial
    swtTraumaTorax.isOn = tipoTrauma.traumaTorax
    swtTraumaBaciaPelve.isOn = tipoTrauma.traumaBaciaPelve
    swtTraumaRaquimedular.isOn = tipoTrauma.traumaRaquimedular
    swtTraumaAbdomen.isOn = tipoTrauma.traumaAbdomen
    swtTraumaMM_SS.isOn = tipoTrauma.traumaMM_SS
    swtTraumaMM_II.isOn = tipoTrauma.traumaMM_II
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    tipoTrauma.tipoPolitraumatismo = swtPolitraumatismo.isOn
    tipoTrauma.tipoTraumatismo = swtTraumatismo.isOn
    tipoTrauma.tipoAfogamento = swtAfogamento.isOn
    tipoTrauma.tipoArmaBranca = swtArmaBranca.isOn
    tipoTrauma.tipoArmaDeFogo = swtArmaDeFogo.isOn
    tipoTrauma.tipoQueimadura = swtQueimadura.isOn
    tipoTrauma.tipoEnvenenamento = swtEnvenenamento.isOn
    
    tipoTrauma.traumaCranioFacial = swtTraumaCranioFacial.isOn
    tipoTrauma.traumaTorax = swtTraumaTorax.isOn
    tipoTrauma.traumaBaciaPelve = swtTraumaBaciaPelve.isOn
    tipoTrauma.traumaRaquimedular = swtTraumaRaquimedular.isOn
    tipoTrauma.traumaAbdomen = swtTraumaAbdomen.isOn
    tipoTrauma.traumaMM_SS = swtTraumaMM_SS.isOn
    tipoTrauma.traumaMM_II = swtTraumaMM_II.isOn
    
    tipoTrauma.traumasInformados = tipoTrauma.tipoPolitraumatismo ||
      tipoTrauma.tipoTraumatismo ||
      tipoTrauma.tipoAfogamento ||
      tipoTrauma.tipoArmaBranca ||
      tipoTrauma.tipoArmaDeFogo  ||
      tipoTrauma.tipoQueimadura  ||
      tipoTrauma.tipoEnvenenamento  ||
      tipoTrauma.traumaCranioFacial  ||
      tipoTrauma.traumaTorax  ||
      tipoTrauma.traumaBaciaPelve  ||
      tipoTrauma.traumaRaquimedular  ||
      tipoTrauma.traumaAbdomen  ||
      tipoTrauma.traumaMM_SS  ||
      tipoTrauma.traumaMM_II

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    
    switch (section) {
    case sectionIndex.tipoTraumaSection.rawValue:
      return 7
    case sectionIndex.traumaSection.rawValue:
      return 7
    default:
      return 0
    }
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
