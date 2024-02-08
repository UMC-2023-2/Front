//
//  SignUpViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/31/24.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import SnapKit

class SignUpViewController: UIViewController {
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("SignUp ID Label", comment: "SignUp page ID Lable")
        return label
    } ()
    
    lazy var idTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("SignUp ID Placeholder", comment: "SignUp page ID textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .always
        return textField
    } ()
    
    lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("SignUp New Password Label", comment: "SignUp page New Password Lable")
        return label
    } ()
    
    lazy var pwTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("SignUp New Password Placeholder", comment: "SignUp page new password textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .always
        return textField
    } ()
    
    lazy var rePasswordLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("SignUp Re-enter Password Label", comment: "SignUp page ID Lable")
        return label
    } ()
    
    lazy var rePasswordTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("SignUp Re-enter Password Placeholder", comment: "SignUp page Re-enter Password textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .always
        return textField
    } ()
    
    lazy var checkIdButton: PPBlackButton = {
        let button = PPBlackButton(buttonStyle: .textfield)
        
        button.setTitle(NSLocalizedString("SignUp ID Check Button", comment: "SignUp page ID check avilavility button"), for: .normal)
        
        return button
    } ()
    
    lazy var signupBtn: PPButton = {
        let button = PPBlackButton(buttonStyle: .bottom)
        button.setTitle(NSLocalizedString("SignUp Button", comment: "Signup Button String"), for: .normal)
        button.isEnabled = false
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        removeBackBtnTitle()
        
        title = NSLocalizedString("SignUp Title", comment: "SignUp page navigationvar title")
        
        view.backgroundColor = .white
        
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(checkIdButton)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(rePasswordLabel)
        view.addSubview(rePasswordTextField)
        view.addSubview(signupBtn)
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(48)
        }
        
        checkIdButton.snp.makeConstraints {
            $0.top.equalTo(idTextField)
            $0.width.equalTo(87)
            $0.height.equalTo(48)
            $0.leading.equalTo(idTextField.snp.trailing).offset(8)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(48)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }
        
        rePasswordLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(48)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(rePasswordLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }
        
        signupBtn.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
