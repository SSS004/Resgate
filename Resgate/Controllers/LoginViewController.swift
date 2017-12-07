//
//  ViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 27/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
  
//##########################################
//MARK: Enumerations
//##########################################

  
//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var txtSenha: UITextField!
  @IBOutlet weak var cmdAcessar: UIButton!
  @IBOutlet weak var chkSalvarUsuario: UISwitch!
  @IBOutlet weak var masterView: UIView!
  
  
//##########################################
//MARK: Properties
//##########################################
  var handle: AuthStateDidChangeListenerHandle?
  
  
//##########################################
//MARK: Private Methods
//##########################################

  
  // ===========================================================================================
  // Verifica se os dados necessários estão preenchidos
  // ===========================================================================================
  private func validarDadosAcesso( email: inout String, senha: inout String) -> Bool {
    
    email = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    senha = senha.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let emailValidado = email.x_isValidEmailAddressStr()
    if (emailValidado == "") {
      // Avisa que o email não é válido
      txtEmail.becomeFirstResponder()
      
      let alerta = Alerta(titulo: "Atenção!", mensagem: "\nEntre com um e-mail válido")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
      
      return false
      
    } else {
      
      email = emailValidado
      
    }
    
    if senha.isEmpty {
      
      txtSenha.becomeFirstResponder()
      
      // Avisa que a senha precisa ser preenchida
      let alerta = Alerta(titulo: "Atenção!", mensagem: "\nEntre com uma senha")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
      
      return false
    }
    
    return true
  }
  
  // ===========================================================================================
  // Verifica se existem UserDefault para preencher a tela com parametros salvos pelo usuario
  // ===========================================================================================
  private func verificaUserDefaultsSalvosPelaAplicacao() {
    
    // Verifica se existe o UserDefault "salvarUsuario"
    if UserDefaults.standard.object(forKey: "salvarUsuario") == nil {
      
      // Não existe, cria o padrão que será salvar usuario
      UserDefaults.standard.set(true, forKey: "salvarUsuario")
      chkSalvarUsuario.setOn(true, animated: false)
      UserDefaults.standard.set("", forKey: "enderecoEmail")
      
    } else {
      
      // ==========================================
      // Existe o UserDefault, atualiza a tela
      // ==========================================
      
      // Atualiza o switch "salvar usuario"
      let salvarUsuario = UserDefaults.standard.bool(forKey: "salvarUsuario")
      chkSalvarUsuario.setOn(salvarUsuario, animated: false)
      
      // Verifica se existe o email salvo
      if let enderecoEmail = UserDefaults.standard.object(forKey: "enderecoEmail") {
        txtEmail.text = (enderecoEmail as! String)
      }
    }
  }
  
  
  
//##########################################
//MARK: Métodos
//##########################################

  // ===========================================================================================
  // Faz com que o foco mude de Field ao teclar Return. Se estiver no
  // ultimo, executa o button cmdAcessar. Para utilizar deve-se declarar UITextFieldDelegate
  // na classe
  // ===========================================================================================
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    
    if (textField == txtSenha) {
      txtSenha.resignFirstResponder()
      cmdAcessar.becomeFirstResponder()
      cmdAcessar.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    return true
    
  }
  
  //##########################################
  //MARK: Actions
  //##########################################

  @IBAction func cmdAcessar(_ sender: Any) {

    view.endEditing(true)
    
    if var emailUsuario = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
      if var senhaUsuario = self.txtSenha.text?.trimmingCharacters(in: .whitespacesAndNewlines) {

        atualizarUserDefaults(salvarUsuario: chkSalvarUsuario.isOn, emailAddress: txtEmail.text!)

        if validarDadosAcesso(email: &emailUsuario, senha: &senhaUsuario) {
          
          SVProgressHUD.show()
          
          txtEmail.text = emailUsuario
          txtSenha.text = senhaUsuario

          let autenticacao = Auth.auth()
          autenticacao.signIn(withEmail: emailUsuario,
                              password: senhaUsuario,
                              completion: { (usuario, erro) in
                                // Não ocorreu erro na execução da funçãos
                                if (erro == nil) {
                                  
                                  // Usuário foi criado ?
                                  if (usuario != nil) {
                                    
                                    SVProgressHUD.dismiss()
                                    self.performSegue(withIdentifier: "segueLogin2Home", sender: nil)
                                    
                                  } else {
                                    
                                    SVProgressHUD.dismiss()
                                    let alerta = Alerta(titulo: "Atenção", mensagem: "Usuário não foi criado")
                                    self.present(alerta.alertaOK(), animated: true, completion: nil)
                                    
                                  }
                                } else {
                                  
                                  if let errCode = AuthErrorCode(rawValue: erro!._code) {
                                    
                                    var mensagemErroString = getFirebaseErrorMessage(errorCode: errCode)
                                    
                                    if mensagemErroString == "" {
                                      mensagemErroString = (erro?.localizedDescription)!
                                    }
                                    
                                    SVProgressHUD.dismiss()
                                    let alerta = Alerta(titulo: "Não foi possivel autenticar o usuário!", mensagem: mensagemErroString)
                                    self.present(alerta.alertaOK(), animated: true, completion: nil)
                                    
                                  } else {
                                    
                                    SVProgressHUD.dismiss()
                                    let alerta = Alerta(titulo: "Atenção", mensagem: "Ocorreu erro desconhecido ao tentar autenticar o usuário")
                                    self.present(alerta.alertaOK(), animated: true, completion: nil)
                                    
                                  }
                                  
                                }
                                
          }
          )
          return
          
        } else {
          return
          
        }
      }
    }

  }
  
  @IBAction func chkSalvarUsuario(_ sender: UISwitch) {
    atualizarUserDefaults(salvarUsuario: chkSalvarUsuario.isOn, emailAddress: txtEmail.text!)
  }
  
  @IBAction func cmdEsqueciSenha(_ sender: Any) {
    
    atualizarUserDefaults(salvarUsuario: chkSalvarUsuario.isOn, emailAddress: txtEmail.text!)

    self.performSegue(withIdentifier: "segueLogin2ResetPassword", sender: nil)
  }

  
  
//##########################################
//MARK: Override functions
//##########################################
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    let autenticacao = Auth.auth()
    autenticacao.useAppLanguage()
    
    //Configurar arredondamento do botao Acessar para ter os cantos arredondados
    self.cmdAcessar.layer.cornerRadius = 7.5
    self.cmdAcessar.clipsToBounds = true
    

    // -------------------------------------------------------------------------------------------------
    // Configura a sequencia de Text Fields quando usuário teclar no botão "Proximo / Next" do teclado
    // E configura o Text Field da senha para tratar o evento do return key
    // Permite que o evento textFieldShouldReturn seja delegado para esta classe
    // Necessario declarar UITextFieldDelegate
    // -------------------------------------------------------------------------------------------------
    UITextField.connectFieldbyReturnKey(fields: [txtEmail, txtSenha], returnKeyType: .done)
    txtSenha.delegate = self

    let clearImage = UIImage(named: "imagem_clear")!
    txtEmail.clearButtonWithImage(clearImage)
    
    let eyeIcon = UIImage(named:"eyes-icon")!
    txtSenha.showPasswordButtonWithImage(eyeIcon)
    
    verificaUserDefaultsSalvosPelaAplicacao()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidDisappear(animated)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    // Torna a barra de navegação invisivel
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    // Garante que o Sign Out ocorra com a autenticação do usuário
    do {
      let autentication = Auth.auth()
      try autentication.signOut()
    } catch {
      
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    atualizarUserDefaults(salvarUsuario: chkSalvarUsuario.isOn, emailAddress: txtEmail.text!)
    SVProgressHUD.dismiss()
    
  }
  
  override func viewWillLayoutSubviews() {

  }
  
  override func viewDidLayoutSubviews() {

  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Evento que ocorre quando usuario iniciar o toque em qualquer ponto da tela que não seja um input
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Esconde o teclado
    view.endEditing(true)
  }
  
  
  
}


