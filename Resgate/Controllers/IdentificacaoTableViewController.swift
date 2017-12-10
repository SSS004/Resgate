//
//  IdentificacaoTableViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class IdentificacaoTableViewController: UITableViewController {

  //##########################################
  //MARK: Enumerations
  //##########################################
  
  
  //##########################################
  //MARK: Outlet to Objects
  //##########################################
  @IBOutlet weak var nome: UITextField!
  @IBOutlet weak var dataNasc: UITextField!
  @IBOutlet weak var nomeMae: UITextField!
  @IBOutlet weak var cpf: UITextField!
  @IBOutlet weak var rg: UITextField!
  @IBOutlet weak var sexo: UITextField!

  
  //##########################################
  //MARK: Private Properties
  //##########################################
  
  
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
  
  
  
  //##########################################
  //MARK: Override functions
  //##########################################
    override func viewDidLoad() {
        super.viewDidLoad()
      
      nome.text =  umaOcorrencia.identificacao.nomeCompleto
      dataNasc.text = umaOcorrencia.identificacao.dataNasc.devolveDataHoraFormatada()
      nomeMae.text = umaOcorrencia.identificacao.nomeMae
      cpf.text = umaOcorrencia.identificacao.cpf
      rg.text = umaOcorrencia.identificacao.rg
      sexo.text = umaOcorrencia.identificacao.sexo
      
      // Mostra o icone para apagar o conteudo do Text Field para os campos passados como parametro
      self.setTextFieldClearButtonImage(textFieldArray: [nome, dataNasc, nomeMae, cpf, rg, sexo ], iconName: "imagem_clear")
      
      // Apos usuario pressionar a tecla retorno, faz com que o foco mude para o proximo Text Field informado no paramertro "fields".
      // Se for o ultimo Text Field da lista, o foco vai para o primeiro da lista
      self.conectarCamposPelaTeclaDeRetornoLoop(fields: [nome, dataNasc, nomeMae, cpf, rg, sexo])

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
        return 6
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
