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
    
    var email = String()
    var password = String()
    var reEnterPassword = String()
    
    lazy var inputFormView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    } ()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("SignUp Email Label", comment: "SignUp page Email Lable")
        return label
    } ()
    
    lazy var emailTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("SignUp Email Placeholder", comment: "SignUp page Email textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .emailAddress
        textField.keyboardType = .asciiCapable
        textField.addTarget(self, action: #selector(usernameDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
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
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword
        textField.clearButtonMode = .always
        textField.enablePasswordToggle()
        textField.addTarget(self, action: #selector(passwordDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .next
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
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword
        textField.clearButtonMode = .always
        textField.enablePasswordToggle()
        textField.addTarget(self, action: #selector(reEnterPasswordDidChange(_:)), for: .editingChanged)
        return textField
    } ()
    
    lazy var checkIdButton: PPBlackButton = {
        let button = PPBlackButton(buttonStyle: .textfield)
        
        button.setTitle(NSLocalizedString("SignUp Email Check Button", comment: "SignUp page ID check avilavility button"), for: .normal)
        
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
        
        inputFormView.addSubview(emailLabel)
        inputFormView.addSubview(emailTextField)
        inputFormView.addSubview(checkIdButton)
        inputFormView.addSubview(pwLabel)
        inputFormView.addSubview(pwTextField)
        inputFormView.addSubview(rePasswordLabel)
        inputFormView.addSubview(rePasswordTextField)
        view.addSubview(inputFormView)
        view.addSubview(signupBtn)
        
        inputFormView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(signupBtn.snp.top).offset(-10)
        }
        
        
        emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(48)
        }
        
        checkIdButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField)
            $0.width.equalTo(87)
            $0.height.equalTo(48)
            $0.leading.equalTo(emailTextField.snp.trailing).offset(8)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(48)
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
            $0.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        signupBtn.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
        }
        
        signupBtn.addTarget(self, action: #selector(signupButtonDidTap(_:)), for: .touchUpInside)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc
    func signupButtonDidTap(_ sender: PPBlackButton) {
        self.navigationController?.pushViewController(NewProfileViewController(), animated: true)
    }
    
    @objc
    func usernameDidChange(_ sender: PPTextField) {
        email = sender.text ?? ""
        signupBtn.isEnabled = checkValid(email, password, reEnterPassword)
    }
    
    @objc
    func passwordDidChange(_ sender: PPTextField) {
        password = sender.text ?? ""
        signupBtn.isEnabled = checkValid(email, password, reEnterPassword)
    }
    
    @objc
    func reEnterPasswordDidChange(_ sender: PPTextField) {
        reEnterPassword = sender.text ?? ""
        signupBtn.isEnabled = checkValid(email, password, reEnterPassword)
    }
    
    func checkValid(_ username: String,_ password: String,_ reEnterPassword: String) -> Bool {
        return (username.count > 2) && (password.count > 2) && (password == reEnterPassword)
    }

}
