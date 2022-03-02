//
//  ForgotPasswordVc.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import UIKit

class ForgotPasswordVc: BaseVC {

    @IBOutlet weak var emailTextfield: UITextField!
    
    var viewModel : AuthVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        if viewModel.isValid {
            viewModel.verifyAccout()
        }else{
            getErrors()
        }
    }
    
   
    private func initViewModel() {
        viewModel = AuthVM(type: .forgetPassword)
        setViewModelObserver(model: viewModel)
        setTFDelegates()
        successResponse()
        
    }
  
}
extension ForgotPasswordVc {
    
    func successResponse() {
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
              
                self.showAlert(titleStr: "Alert", messageStr: self.viewModel.message ?? "check email", okButtonTitle: "OK", cancelButtonTitle: nil) { dismissedWithButton in
                   // self.navigationController?.popViewController(animated: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OPTVc") as! OPTVc
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
 
            
            }
            
        }
    }
    
    func setTFDelegates(){

        emailTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = emailTextfield.text ?? ""
    }
    
   
    
    func getErrors() {
        for rule in viewModel.brokenRules{
                self.showAlert(titleStr: "Alert", messageStr: rule.message, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
                return
        }
    }
}
