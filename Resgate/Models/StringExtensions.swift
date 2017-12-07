//
//  StringExtensions.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 29/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

extension String
{
  
    enum PasswordValidationError: Error {
      case minimumLenghtGreaterThanmaximumLenght
      case minimumLenght(lenght: Int)
      case maximumLenght(lenght: Int)
    }

    // =======================================================================
    // Retorna uma string limitada pela quantidade de caracteres passado
    // como parametro
    // =======================================================================
    func safelyLimitedTo(length n: Int)->String {
        let c = self
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    // =======================================================================
    // Retorna true se a string contém um endereço válido de email, c.c.
    // retorna false
    // =======================================================================
    func x_isValidEmailAddressBool() -> Bool {
        
        var strLen = 0
        
        let email = self
        
        // Elimina os espaços do inicio e fim da string e deixa os caracteres minusculos
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // Verifica se existe espaço no meio da string ou é uma string vazia
        if (trimmedEmail.contains(" ") || trimmedEmail.isEmpty) {
            return false
        }
        
        // ==========================================================
        // Valida se o email contém somente caracteres válidoss
        // ==========================================================
        strLen = trimmedEmail.count
        do
        {
            // Verifica se a string possui somente letras, numeros e também os caracteres "." ou "-" ou "_"
            let regex = try NSRegularExpression(pattern: "[0-9a-z\\.\\_\\-\\@]", options: .caseInsensitive)
            if (regex.matches(in: trimmedEmail, options: [], range: NSMakeRange(0, strLen)).count != strLen) {
                return false
            }
        }
        catch {
            print("invalid regex: \(error.localizedDescription)")
        }
        
        // Separa palavras da string utilizando como separadores "@", ".", "-" ou "_"s
        let charsetEspeciais = CharacterSet(charactersIn: ".-_@")
        let partesTexto = trimmedEmail.components(separatedBy: charsetEspeciais)
        
        // ===========================================================
        // Na separação dos componentes do email, se existir um componente
        // vazio, indica uma das seguintes situações:
        //  1) Caracter especial no início de alguma parte
        //  2) Caracter especial no fim de alguma parte
        //  3) Caracter especial junto de outro caracter especials
        // Neste caso o email é invalido
        // ===========================================================
        let verPartesVazias = partesTexto.filter { $0.isEmpty }
        if (verPartesVazias.count > 0) {
            return false
        }
        
        // ===========================================================
        // Separa o endereco de email usando o separador "@"
        // Um email possui o seguinte formato:  parte-local@dominio
        // partesArroba[0] contém a parte-local
        // partesArroba[0] contém o dominio
        // ===========================================================
        let partesArroba = trimmedEmail.components(separatedBy: "@")
        
        // O email pode ter somente 1 arroba
        if (partesArroba.count != 2) {
            return false
        } else if (partesArroba[0] == "") {
            // Nao existe palavra antes do @
            return false
        } else if (partesArroba[1] == "") {
            // Nao existe palavra depois do @
            return false
        }
        
        let nomeDominio = partesArroba[1]
        
        // ==========================================================
        // Verifica se o dominio do email esta correto
        // ==========================================================
        // Separa palavras da string com o separador "."
        let partesDominio = nomeDominio.components(separatedBy: ".")
        
        // dominio precisa ter no minimo duas partes
        if (partesDominio.count <= 1) {
            return false
        }
        
        // Verifica se o final do domínio contém dois ou tres caracteres
        let parteFinal = partesDominio[partesDominio.count-1]
        
        strLen = parteFinal.count
        if ((strLen != 2) && (strLen != 3)) {
            return false
        }
        
        return true
    }

    // =======================================================================
    // Verifica se a string contém um email válido
    // Retorna uma string vazia se não for válido, caso contrário
    // retorna uma string com o email em minuscula e sem espaços em branco
    // no inicio e final da String
    // =======================================================================
    func x_isValidEmailAddressStr() -> String {
        
        if (self.x_isValidEmailAddressBool()) {
            return self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        }
        return ""
    }
    
    // =======================================================================
    // Verifica se a string possui um nome válido:
    //  1) Não pode ter caracteres especiais
    //  2) Precisa ter nome e sobrenome
    //
    // Retorna uma string vazia se o nome não estiver válido, caso contrário
    // retorna o nome limpando espaços duplicados, e espaços no inicio e fim
    // da string
    // =======================================================================
    func x_validaNome() -> String
    {
        // Separa as palavras da string
        let arrayPalavras = self.components(separatedBy: .whitespacesAndNewlines)
        // Remove as palavras vazias
        let palavras = arrayPalavras.filter { !$0.isEmpty }
        if (palavras.count <= 1) {
            return ""
        }
        
        // Cria uma string com o nome tratado:
        // Sem espaços no inicio e fim da String
        // Sem espaços duplicados
        let nomeTratado = palavras.joined(separator: " ")
        let strLen = nomeTratado.count
        
        do
        {
            let regex = try NSRegularExpression(pattern: "[a-zA-Z0-9.àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð '\\-]", options: .caseInsensitive)
            if regex.matches(in: nomeTratado, options: [], range: NSMakeRange(0, strLen)).count == strLen {
                return nomeTratado
            }
        }
        catch {
            print("invalid regex: \(error.localizedDescription)")
        }
        
        return ""
        
    }
    
    // =======================================================================
    // Verifica se a string contém um USER NAME valido:
    // Não pode ter caracteres especiais, somente ponto, undescore e traço
    //
    // Retorna uma string vazia se o nome não estiver válido, caso contrário
    // retorna o nome limpando espaços duplicados, e espaços no inicio e fim
    // da string
    // =======================================================================
    func x_validaUserName() -> String
    {
        let strNew = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let strLen = strNew.count
        if (strLen == 0) {
            return ""
        }
        
        do
        {
            let regex = try NSRegularExpression(pattern: "[0-9a-zA-Z\\.\\_\\-]", options: .caseInsensitive)
            if regex.matches(in: strNew, options: [], range: NSMakeRange(0, strLen)).count == strLen {
                return strNew.uppercased()
            }
        }
        catch {
            print("invalid regex: \(error.localizedDescription)")
        }
        return ""
    }

  // =========================================================================================================
  // Verifica se a string contém uma senha válida.
  //
  // Parametros:
  //  - minimumLenght:              Tamanho mínimo da senha (aceita valores entre 6 e 40)
  //  - maximumLenght:              Tamanho máximo da senha (aceita valores entre 6 e 40)
  //  - numericCharacterRequired:   Exige que a senha tenha no mínimo um caracter numérico
  //  - lowercaseCharacterRequired: Exige que a senha tenha no mínimo um caracter em letra minuscula
  //  - uppercaseCharacterRequired: Exige que a senha tenha no mínimo um caracter em letra maisucula
  //  - symbolCharacterRequired:    Exige que a senha tenha no mínimo um caracter especial (simbolo)
  //       Os caracteres aceitos são: $ ! @ # $ & % * ? + - , ; . ^ ~ ` ´ ' = > < : € _ | ) (
  //
  // Retorna true se a senha atende aos parametros informados.
  // Se nenhum dos parametros de exigencia minima (numericCharacterRequired, lowercaseCharacterRequired,
  // uppercaseCharacterRequired e symbolCharacterRequired) for true, então a expressão regular
  // obrigará que a senha possa somente ter os letras maiusculas, minusculas e digitos numericos
  // sem obrigar que tenha pelo menos um destes tipos, ou seja, o usuario podera ter senha com somente
  // digitos numericos
  // =========================================================================================================
  func x_isPasswordValid(minimumLenght: Int,
                         maximumLenght: Int,
                         numericCharacterRequired: Bool,
                         lowercaseCharacterRequired: Bool,
                         uppercaseCharacterRequired: Bool,
                         symbolCharacterRequired: Bool) throws -> Bool {
    
    let minLenght = 4
    let maxLenght = 40
    
    let password = self
    
    if (minimumLenght > maximumLenght) {
      throw PasswordValidationError.minimumLenghtGreaterThanmaximumLenght
    }
    
    if (minimumLenght < minLenght) {
      throw PasswordValidationError.minimumLenght(lenght: minLenght)
    }
    
    if (maximumLenght > maxLenght) {
      throw PasswordValidationError.maximumLenght(lenght: maxLenght)
    }
  
/* ---------------------------------------------------------------------------------------------------
     Quando existe a exigencia de no minimo algum tipo de carater,
     a Expressão Regular contém o seguinte formato:
     
     ^                                       Inicio da ancora
     (?=.*[a-z])                             Obriga no mínimo uma letra minuscula
     (?=.*[A-Z])                             Obriga no mínimo uma letra maiuscula
     (?=.*[0-9])                             Obriga no mínimo uma digito numerico
     (?=.*[$!@#$&%*?+-,;.^~`´'=><:€\\_|)(])  Obriga no mínimo um caracter simbolo (especial)
     .{n,m}                                  Obriga tamanho minimo de n caracteres e maximo de m caracteres
     $                                       Fim da ancora

   ---------------------------------------------------------------------------------------------------
*/
    var predicateRegEx:String = ""
    
    if (numericCharacterRequired) {
      predicateRegEx = "(?=.*[0-9])"
    }
    
    if (lowercaseCharacterRequired) {
      if (predicateRegEx == "") {
        predicateRegEx = "(?=.*[a-z])"
      } else {
        predicateRegEx += "(?=.*[a-z])"
      }
    }
    
    if (uppercaseCharacterRequired){
      if (predicateRegEx == "") {
        predicateRegEx = "(?=.*[A-Z])"
      } else {
        predicateRegEx += "(?=.*[A-Z])"
      }
    }
    
    if (symbolCharacterRequired) {
      if (predicateRegEx == "") {
        predicateRegEx = "(?=.*[A-Z])(?=.*[$!@#$&%*?+-,;.^~`´'=><:€\\_|)(])"
      } else {
        predicateRegEx += "(?=.*[A-Z])(?=.*[$!@#$&%*?+-,;.^~`´'=><:€\\_|)(])"
      }
    }
    
    // ======================================================================
    // Se todos os requerimentos de regras estiverem false, então
    // adota que a senha aceita somente maiusculas, minusculas e numeros
    // sem obrigar um minimo de algum deles
    // ======================================================================
    if (predicateRegEx == "") {
      predicateRegEx = "[A-Za-z0-9]{\(minimumLenght),\(maximumLenght)}"
    } else {
      predicateRegEx = "^\(predicateRegEx).{\(minimumLenght),\(maximumLenght)}$"
    }
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", predicateRegEx)
    
    return passwordTest.evaluate(with: password)
    
  } // *** Fim x_isPasswordValid
  
}
