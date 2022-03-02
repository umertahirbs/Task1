//
//  Register+.swift
//  Task1
//
//  Created by Umer Tahir on 03/03/2022.
//

import Foundation
import UIKit
extension RegisterVc {
    
    
    func setTFDelegates(){

        emailTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstNameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = emailTextfield.text ?? ""
        viewModel.password.value = passwordTextfield.text ?? ""
        viewModel.firstName.value = firstNameTextfield.text ?? ""
        viewModel.lastName.value = lastNameTextfield.text ?? ""

    }
    
    
    func getErrors() {
        for rule in viewModel.brokenRules{
                self.showAlert(titleStr: "Alert", messageStr: rule.message, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
                return
        }
    }

}
