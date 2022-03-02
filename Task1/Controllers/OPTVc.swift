//
//  OPTVc.swift
//  Task1
//
//  Created by Umer Tahir on 03/03/2022.
//

import UIKit
import OTPFieldView

class OPTVc: UIViewController {

    
    @IBOutlet weak var pinView: OTPFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
    }
    

  

    func setupOtpView(){
            self.pinView.fieldsCount = 8
            self.pinView.fieldBorderWidth = 2
            self.pinView.defaultBorderColor = UIColor.black
            self.pinView.filledBorderColor = UIColor.blue
            self.pinView.cursorColor = UIColor.blue
            self.pinView.displayType = .underlinedBottom
            self.pinView.fieldSize = 40
            self.pinView.separatorSpace = 8
            self.pinView.shouldAllowIntermediateEditing = false
            self.pinView.delegate = self
            self.pinView.initializeUI()
        }

}

extension OPTVc: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestPassVc") as! RestPassVc
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
    }
}
