//
//  BaseVC.swift
//  Pod.iOS
//
//  Created by Tayyab Tariq on 22/10/21.
//

import UIKit

class BaseVC: UIViewController,AlertService {
 func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func showProgressHUD() {
        LoadingOverlay.shared.showOverlay(view: self.view)
    }
    func hideProgressHUD() {
        LoadingOverlay.shared.hideOverlayView(view: self.view)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension BaseVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
extension BaseVC{
    func setViewModelObserver(model:ViewModel){
        hideKeyboardWhenTappedAround()
        var viewModel = model
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let _ = viewModel.isLoading ? self?.showProgressHUD() : self?.hideProgressHUD()
            }
        }
        viewModel.showAlertClosure = {  [weak self] in
            if let error = viewModel.error {
                print(error)
                DispatchQueue.main.async {
                    self?.callAlert(msg: error)
                }
            }
        }
    }
    func showBrokenRules(message:String){
        DispatchQueue.main.async {
            self.callAlert(msg: message)
        }
    }
    
    func goToDashboard(){
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "TabVc") as? TabVc else { return }
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.topViewController() {
                rootViewController.present(vc, animated: true, completion: nil)
            }
        }
    }
}


