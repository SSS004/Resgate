//
//  ocorrenciaTableViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class ocorrenciaTableViewController: UITableViewController {

//##########################################
//MARK: Enumerations
//##########################################
  private enum sectionIndex: Int {
    case ocorrenciaSection = 0
    case informacaoSection = 1
    case elegibilidadeSection = 2
  }

  private enum rowIndexAtOcorrenciaSection: Int {
    case idxData = 0
    case idxEndereco = 1
  }
  
  private enum rowIndexAtInformacaoSection: Int {
    case idxDocumentos = 0
    case idxTipoTrauma = 1
    case idxInformacaoClinica = 2
  }

  private enum rowIndexAtEligibilidadeSection: Int {
    case idxIdentificacao = 0
    case idxOperadora = 1
    case idxHospital = 2
  }

//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var lblDataOcorrencia: UILabel!

  @IBOutlet weak var lblTotalDocumentos: UILabel!
  @IBOutlet weak var imgCheckOperadora: UIImageView!

  @IBOutlet weak var lblEndereco: UILabel!
  
  @IBOutlet weak var setaEndereco: UIButton!
  
  @IBOutlet weak var setaIdentificacao: UIButton!
  
  @IBOutlet weak var setaDocumentos: UIButton!
  
  @IBOutlet weak var setaTipoTrauma: UIButton!
  
  @IBOutlet weak var setaInformacaoClinica: UIButton!
  
  @IBOutlet weak var lblTotalHospitais: UILabel!
  
  
//##########################################
//MARK: Properties
//##########################################
  
  // A View que chamar esta deve inicializar as seguintes variáveis
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
  @IBAction func bbiLigarCallCenter(_ sender: UIBarButtonItem) {
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
  }
  

//##########################################
//MARK: Override functions
//##########################################
    override func viewDidLoad() {

      super.viewDidLoad()
      
      // --------------------
      // Arredonda os labels
      // --------------------
      lblTotalDocumentos.layer.cornerRadius = lblTotalDocumentos.frame.width/2
      lblTotalDocumentos.layer.masksToBounds = true

      lblTotalHospitais.layer.cornerRadius = lblTotalHospitais.frame.width/2
      lblTotalHospitais.layer.masksToBounds = true
      
      // -------------------------------------------------------------------
      //  Verifica se as variaveis foram passadas pela VIEW origem
      // -------------------------------------------------------------------
      if (umaOcorrencia == nil) {
        let alerta = Alerta(titulo: "*** IMPORTANTE ***", mensagem: "\nVariável umaOcorrencia não foi inicializada!")
        self.present(alerta.alertaOK(), animated: true, completion: nil)
        return
      }

      // Se for uma nova ocorrencia, mostra a View Controller do MAPA
      if (umaOcorrencia.inicializado <= 1)  {
        
        self.performSegue(withIdentifier: "segueOcorrencia2Mapa", sender: nil)
        return
      }
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      
    }
  
  // Uma SEGUE foi executada para chamar uma View Controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "segueOcorrencia2Mapa" {
      
      // Chamou a view que mostra o MAPA, passa para a segue o endereco
      if let ocorrenciaMapa = segue.destination as? MapaNovoAtendimentoViewController {
        ocorrenciaMapa.enderecoSalvo = umaOcorrencia.Endereco
      }
      
    } else if (segue.identifier == "segueOcorrencia2Foto") {

      // Chamou a view que mostra o MAPA, passa para a segue o endereco
      if let ocorrenciaFotos = segue.destination as? PhotoViewController {
        ocorrenciaFotos.umaOcorrencia = self.umaOcorrencia
      }

    } else if (segue.identifier == "segueOcorrencia2TipoTrauma") {
      
      // Chamou a view que mostra o MAPA, passa para a segue o endereco
      if let ocorrenciaTipoTrauma = segue.destination as? TipoTraumaTableViewController {
        ocorrenciaTipoTrauma.umaOcorrencia = self.umaOcorrencia
      }
      
    }

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    self.tableView.tableFooterView = UIView(frame: .zero)
    self.tableView.tableFooterView?.isHidden = true
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    lblDataOcorrencia.text = dateFormatter.string(from: umaOcorrencia.dataOcorrencia)

    lblEndereco.text = umaOcorrencia.Endereco.addressName
    // Se for uma nova ocorrencia, mostra a View Controller do MAPA
    if (umaOcorrencia.Endereco.location.coordinate.latitude == 0)  {
      setaEndereco.setImage(#imageLiteral(resourceName: "need-information"), for: UIControlState.normal)
    }  else {
      setaEndereco.setImage(#imageLiteral(resourceName: "Next"), for: UIControlState.normal)
    }

    lblTotalDocumentos.text = String(umaOcorrencia.documentos.totalImagens)
    // Se for uma nova ocorrencia, mostra a View Controller do MAPA
    if (umaOcorrencia.documentos.totalImagens == 0)  {
      setaDocumentos.setImage(#imageLiteral(resourceName: "need-information"), for: UIControlState.normal)
    }  else {
      setaDocumentos.setImage(#imageLiteral(resourceName: "Next"), for: UIControlState.normal)
    }

    if (!umaOcorrencia.tipoTrauma.traumasInformados)  {
      setaTipoTrauma.setImage(#imageLiteral(resourceName: "need-information"), for: UIControlState.normal)
    }  else {
      setaTipoTrauma.setImage(#imageLiteral(resourceName: "Next"), for: UIControlState.normal)
    }
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
 
    super.viewWillDisappear(animated)
      
 
  }
  

  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    var rowHeight:CGFloat = 60.0
    
    // ------------------------------------------------
    // Selecionado linha da seção de informação da
    // ocorrência ?? (Primeira seção da Table View)
    // ------------------------------------------------
    if (indexPath[0] == sectionIndex.informacaoSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção Atendimentos
      // ------------------------------------------
      if (indexPath[1] == rowIndexAtInformacaoSection.idxInformacaoClinica.rawValue) {
        if (umaOcorrencia.inicializado  <= 1) {
          rowHeight = 0.0
        } else {
          rowHeight = 60.0
        }
      }
    } else if (indexPath[0] == sectionIndex.elegibilidadeSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção Atendimentos
      // ------------------------------------------
      if (indexPath[1] == rowIndexAtEligibilidadeSection.idxIdentificacao.rawValue) {
        if (umaOcorrencia.inicializado <= 1) {
          rowHeight = 0.0
        } else {
          rowHeight = 60.0
        }

      } else if (indexPath[1] == rowIndexAtEligibilidadeSection.idxOperadora.rawValue) {
        if (umaOcorrencia.inicializado  <= 1) {
          rowHeight = 0.0
        } else {
          rowHeight = 60.0
        }
      } else if (indexPath[1] == rowIndexAtEligibilidadeSection.idxHospital.rawValue) {
        if (umaOcorrencia.inicializado  <= 1) {
          rowHeight = 0.0
        } else {
          rowHeight = 60.0
        }
      }
    }
    
    return rowHeight
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if (section == sectionIndex.elegibilidadeSection.rawValue) && (umaOcorrencia.inicializado  <= 1) {
      return 0.0
    }
    return UITableViewAutomaticDimension
  }
  

    
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 3
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    
    switch (section) {
    case sectionIndex.ocorrenciaSection.rawValue:
      return 2
    case sectionIndex.informacaoSection.rawValue:
      return 3
    case sectionIndex.elegibilidadeSection.rawValue:
      return 3
    default:
      return 0
    }
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.tableView.deselectRow(at: indexPath, animated: true)
    
    // ------------------------------------------------
    // Selecionado linha da seção de informação da
    // ocorrência ?? (Primeira seção da Table View)
    // ------------------------------------------------
    if (indexPath[0] == sectionIndex.ocorrenciaSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção Atendimentos
      // ------------------------------------------
      if (indexPath[1] == rowIndexAtOcorrenciaSection.idxEndereco.rawValue) {
        
        // Chama a tela do MAPA
        self.performSegue(withIdentifier: "segueOcorrencia2Mapa", sender: nil)
        
      }
      
      
    } else if (indexPath[0] == sectionIndex.informacaoSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção INFORMAÇÃO
      // ------------------------------------------
      if (indexPath[1] == rowIndexAtInformacaoSection.idxDocumentos.rawValue) {
        
        // Chama a tela da CAMERA de FOTO
        self.performSegue(withIdentifier: "segueOcorrencia2Foto", sender: nil)
        
      } else if (indexPath[1] == rowIndexAtInformacaoSection.idxTipoTrauma.rawValue) {
        
        // Chama a tela do tipo Trauma
        self.performSegue(withIdentifier: "segueOcorrencia2TipoTrauma", sender: nil)
        
      } else if (indexPath[1] == rowIndexAtInformacaoSection.idxInformacaoClinica.rawValue) {
        
        // Chama a tela do tipo Trauma
        self.performSegue(withIdentifier: "segueOcorrencia2InfoClinica", sender: nil)
        
      }
      
      
    } else if (indexPath[0] == sectionIndex.elegibilidadeSection.rawValue) {
      // ------------------------------------------
      // Selecionado linha da seção ELEGIBILIDADE
      // ------------------------------------------
      
      if (indexPath[1] == rowIndexAtEligibilidadeSection.idxIdentificacao.rawValue) {
        
        // Chama a tela da CAMERA de FOTO
        self.performSegue(withIdentifier: "segueOcorrencia2Identificacao", sender: nil)
        
      } else if (indexPath[1] == rowIndexAtEligibilidadeSection.idxOperadora.rawValue) {
        
        // Chama a tela do tipo Trauma
        self.performSegue(withIdentifier: "segueOcorrencia2Operadora", sender: nil)
        
      } else if (indexPath[1] == rowIndexAtEligibilidadeSection.idxHospital.rawValue) {
        
        // Chama a tela do tipo Trauma
        self.performSegue(withIdentifier: "segueOcorrencia2Hospital", sender: nil)
        
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
