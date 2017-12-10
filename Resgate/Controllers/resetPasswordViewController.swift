//
//  ResetPasswordViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 01/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
 
//##########################################
//MARK: Enumerations
//##########################################
  
  
  
//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var cmdCadastrar: UIButton!
  @IBOutlet weak var aivSpinner: UIActivityIndicatorView!
  @IBOutlet weak var masterView: UIView!
  
  
//##########################################
//MARK: Properties
//##########################################

  
  
//##########################################
//MARK: Private Methods
//##########################################

  

//##########################################
//MARK: Métodos
//##########################################
  
  // ===========================================================================================
  // Se o text field que recebeu a tecla RETURN for o email, executa o comando para enviar
  // o reset de senha
  // ===========================================================================================
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    if (textField == txtEmail) {
      txtEmail.resignFirstResponder()
      cmdCadastrar.becomeFirstResponder()
      cmdCadastrar.sendActions(for: UIControlEvents.touchUpInside)
    }
    return true
  }

  
  
//##########################################
//MARK: Actions
//##########################################
  @IBAction func cmdCadastrar(_ sender: UIButton) {
    
    // Esconde o teclado
    view.endEditing(true)
    
    self.aivSpinner.startAnimating()
    
    if let emailUsuario = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
      
      let email = emailUsuario.lowercased()
      let emailValidado = email.x_isValidEmailAddressStr()
      
      if (emailValidado == "") {
        
        txtEmail.becomeFirstResponder()
        self.aivSpinner.stopAnimating()
        
        self.mostraAlertaOK(titulo: "Atenção!", mensagem: "\nEntre com um e-mail válido")
        
        return
        
      }
      
      txtEmail.text = email
      
      let autenticacao = Auth.auth()
      
      autenticacao.languageCode = "br"
      autenticacao.sendPasswordReset(withEmail: email, completion: { (erro) in
        
        if (erro == nil) {
          
          self.aivSpinner.stopAnimating()
          
          let alerta = UIAlertController(title: "Aviso", message:  "Você receberá um email para resetar sua senha.", preferredStyle: .alert)
          let acaoOK = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            
            _ = self.navigationController?.popViewController(animated: true)
            
          }
          
          alerta.addAction(acaoOK)
          self.present(alerta, animated: true, completion: nil)
          
        } else {
          
          if let errCode = AuthErrorCode(rawValue: erro!._code) {
            
            var mensagemErroString = getFirebaseErrorMessage(errorCode: errCode)
            
            if mensagemErroString == "" {
              mensagemErroString = (erro?.localizedDescription)!
            }
            
            self.aivSpinner.stopAnimating()
            
            self.mostraAlertaOK(titulo: "Não foi possivel enviar email para o usuário!", mensagem: mensagemErroString)

            
          } else {
            
            self.aivSpinner.stopAnimating()
            
            self.mostraAlertaOK(titulo: "Atenção!", mensagem: "Ocorreu erro desconhecido ao tentar enviar e-mail para o usuário")
 
          }
        }
      })
      
    }
  }
  
//##########################################
//MARK: Override functions
//##########################################
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // ************************************
    // Alterar bordas dos Text Fields
    // ************************************
//    let lnColor : UIColor = UIColor( red: 0.047, green: 0.137, blue: 0.702, alpha: 0.6 )  // Seleciona a cor
    txtEmail.setBorderAttrib(cornerRadius: 4.0, borderWidth: 1.0, lineColor: UIColor.white)
    
    //Configurar arredondamento do botao Acessar para ter os cantos arredondados
    self.cmdCadastrar.layer.cornerRadius = 7.5
    self.cmdCadastrar.clipsToBounds = true
    
    aivSpinner.hidesWhenStopped = true

    // -------------------------------------------------------------------------------------------------
    // Configura a sequencia de Text Fields quando usuário teclar no botão "Proximo / Next" do teclado
    // E configura o Text Field do EMAIL para tratar o evento do return key
    // Permite que o evento textFieldShouldReturn seja delegado para esta classe
    // Necessario declarar UITextFieldDelegate
    // -------------------------------------------------------------------------------------------------
    self.conectarCamposPelaTeclaDeRetorno(fields: [txtEmail], returnKeyType: .done)
    txtEmail.delegate = self
    // -------------------------------------------------------------------------------------------------

    // Customiza o icone para apagar o texto de um TextFields
    self.setTextFieldClearButtonImage(textFieldArray: [txtEmail], iconName: "imagem_clear")

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    // Torna a barra de navegação visivel
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    self.aivSpinner.stopAnimating()
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Evento que ocorre quando usuario iniciar o toque em qualquer ponto da tela que não seja um input
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    super.touchesBegan(touches, with: event)
    
    // Esconde o teclado
    view.endEditing(true)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

