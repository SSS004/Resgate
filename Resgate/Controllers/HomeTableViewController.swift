//
//  HomeTableViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth


class HomeTableViewController: UITableViewController {


//##########################################
//MARK: Enumerations
//##########################################
  private enum sectionIndex: Int {
    case atendimentosSection = 0
    case totaisSection = 1
  }
  
  private enum rowIndexAtAtendimentoSection: Int {
    case novoAtendimento = 0
    case emAndamento = 1
  }

  private enum rowIndexAtTotalSection: Int {
    case totalPlantao = 0
    case totalMes = 1
  }

//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var cmdNovoAtendimento: UIButton!
  @IBOutlet weak var lblTotalEmAndamento: UILabel!
  @IBOutlet weak var lblTotalPlantao: UILabel!
  @IBOutlet weak var lblTotalMes: UILabel!
  
  
//##########################################
//MARK: Properties
//##########################################
  var umaOcorrencia: Ocorrencia!


//##########################################
//MARK: Private Methods
//##########################################



//##########################################
//MARK: Métodos
//##########################################



//##########################################
//MARK: Actions
//##########################################
  @IBAction func bbiSair(_ sender: UIBarButtonItem) {
    
    // Encerra a sessão do usuário
    let autenticacao = Auth.auth()
    do {
      try autenticacao.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    
    // Mostra a tela de Login
    self.performSegue(withIdentifier: "segueHome2Login", sender: nil)

  }
  
  @IBAction func bbiTelefone(_ sender: UIBarButtonItem) {
    
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
    
  }
  
  
  
//##########################################
//MARK: Override functions
//##########################################
override func viewDidLoad() {
  
        super.viewDidLoad()
  
        self.umaOcorrencia = Ocorrencia()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
  
    }

  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    self.umaOcorrencia.inicializado = self.umaOcorrencia.inicializado + 1
    
    // -------------------------------------------------------
    // Somente com as linhas vazias no final da Table View
    // -------------------------------------------------------
    self.tableView.tableFooterView = UIView(frame: .zero)
    self.tableView.tableFooterView?.isHidden = true

    // -----------------------------------------------
    // Deixa os labels de Totais redondos
    // -----------------------------------------------
    lblTotalEmAndamento.layer.cornerRadius = lblTotalEmAndamento.frame.width/2
    lblTotalEmAndamento.layer.masksToBounds = true
    lblTotalPlantao.layer.cornerRadius = lblTotalPlantao.frame.width/2
    lblTotalPlantao.layer.masksToBounds = true
    lblTotalMes.layer.cornerRadius = lblTotalMes.frame.width/2
    lblTotalMes.layer.masksToBounds = true

    if (self.umaOcorrencia.inicializado <= 1) {
      lblTotalEmAndamento.text = "0"
      lblTotalPlantao.text = "3"
      lblTotalMes.text = "35"
    } else {
      lblTotalEmAndamento.text = "1"
      lblTotalPlantao.text = "4"
      lblTotalMes.text = "36"
    }

    // Torna a barra de navegação invisivel
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.navigationItem.hidesBackButton = true
    
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
    case sectionIndex.atendimentosSection.rawValue:
      return 2
    case sectionIndex.totaisSection.rawValue:
      return 2
    default:
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.tableView.deselectRow(at: indexPath, animated: true)
    
    // Selecionado linha da seção Atendimentos ?
    if (indexPath[0] == sectionIndex.atendimentosSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção Atendimentos
      // ------------------------------------------
      if (indexPath[1] == rowIndexAtAtendimentoSection.novoAtendimento.rawValue) {
        
       self.performSegue(withIdentifier: "segueHome2NovaOcorrencia", sender: nil)
        
      } else if (indexPath[1] == rowIndexAtAtendimentoSection.emAndamento.rawValue) {
        
        self.performSegue(withIdentifier: "segueHome2NovaOcorrencia", sender: nil)

      }
      

    } else if (indexPath[0] == sectionIndex.atendimentosSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção Histórico
      // ------------------------------------------

    }

  }

  // Uma SEGUE foi executada para chamar uma View Controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "segueHome2NovaOcorrencia" {
      
      // Chamou a view que mostra o MAPA, passa para a segue o endereco
      if let ocorrencia = segue.destination as? ocorrenciaTableViewController {
        // Cria um object do tipo Ocorrencia e passa como parametro
        ocorrencia.umaOcorrencia = self.umaOcorrencia
      }
      
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
