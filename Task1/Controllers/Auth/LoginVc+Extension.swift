//
//  LoginVc+Extension.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import Foundation
import UIKit


extension LoginVc {
    
    func setTFDelegates(){

        emailTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfied.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = emailTextfield.text ?? ""
        viewModel.password.value = passwordTextfied.text ?? ""
    }
    
   
    
    func getErrors() {
        for rule in viewModel.brokenRules{
                self.showAlert(titleStr: "Alert", messageStr: rule.message, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
                return
        }
    }
}
