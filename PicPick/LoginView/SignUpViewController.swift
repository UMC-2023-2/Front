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
    var emailIsValid: Bool = false
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
        textField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        return textField
    } ()
    
    lazy var emailIsValidLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.captionLarge500.font
        return label
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
    
    lazy var checkEmailButton: PPBlackButton = {
        let button = PPBlackButton(buttonStyle: .textfield)
        
        button.setTitle(NSLocalizedString("SignUp Email Check Button", comment: "SignUp page ID check avilavility button"), for: .normal)
        button.addTarget(self, action: #selector(checkEmailDidTap(_:)), for: .touchUpInside)
        button.isEnabled = emailIsValid
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
        inputFormView.addSubview(checkEmailButton)
        inputFormView.addSubview(emailIsValidLabel)
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
        
        checkEmailButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField)
            $0.width.equalTo(87)
            $0.height.equalTo(48)
            $0.leading.equalTo(emailTextField.snp.trailing).offset(8)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        emailIsValidLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(6)
            $0.leading.equalTo(emailTextField.snp.leading).offset(16)
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
    
    @objc
    func signupButtonDidTap(_ sender: PPBlackButton) {
        self.navigationController?.pushViewController(NewProfileViewController(), animated: true)
    }
    
    @objc
    func emailDidChange(_ sender: PPTextField) {
        email = sender.text ?? ""
        checkEmailButton.isEnabled = email.isValidEmail()
        emailIsValidLabel.text = nil
        emailIsValid = false
        signupBtn.isEnabled = checkValid(password, reEnterPassword)
    }
    
    @objc
    func passwordDidChange(_ sender: PPTextField) {
        password = sender.text ?? ""
        signupBtn.isEnabled = checkValid(password, reEnterPassword)
    }
    
    @objc
    func reEnterPasswordDidChange(_ sender: PPTextField) {
        reEnterPassword = sender.text ?? ""
        signupBtn.isEnabled = checkValid(password, reEnterPassword)
    }
    
    @objc
    func checkEmailDidTap(_ sender: PPButton) {
        UserService.shared.isDuplicate(email: email) { response in
            switch response {
            case .success(let data):
                if let data = data as? IsDuplicateResponse {
                    if(data.isDuplicate) {
                        self.emailIsValid = false
                        self.emailIsValidLabel.text = "*존재하는 이메일 입니다."
                        self.emailIsValidLabel.textColor = R.Color.systemRed
                    } else {
                        self.emailIsValid = true
                        self.emailIsValidLabel.text = "*사용 가능한 이메일 입니다."
                        self.emailIsValidLabel.textColor = R.Color.pointNormal
                    }
                }
                self.signupBtn.isEnabled = self.checkValid(self.password, self.reEnterPassword)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func checkValid(_ password: String,_ reEnterPassword: String) -> Bool {
        return (emailIsValid) && (password.count > 2) && (password == reEnterPassword)
    }

}
