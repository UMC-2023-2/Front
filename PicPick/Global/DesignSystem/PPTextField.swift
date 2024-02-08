//
//  PPTextField.swift
//  PicPick
//
//  Created by Jaeuk on 1/29/24.
//

import UIKit
import PicPick_Resource

class PPTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.Color.gray300
        textColor = R.Color.gray700
        autocapitalizationType = .none
        font = PPFont.bodyLarge500.font
        layer.cornerRadius = 24
        clipsToBounds = true
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = PPFont.bodyLarge500.lineHeight
        style.minimumLineHeight = PPFont.bodyLarge500.lineHeight

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (PPFont.bodyLarge500.lineHeight - font!.lineHeight),
            .font: PPFont.bodyLarge500.font
        ]
        defaultTextAttributes = attributes
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 16, dy: 13)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 13)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 13)
    }
    
    convenience init(placeholder: String) {
        self.init()
        let attributes = [
            NSAttributedString.Key.foregroundColor: R.Color.gray600
        ]

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:attributes)
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(R.Image.icoEye24.withRenderingMode(.alwaysTemplate), for: .normal)
        }else{
            button.setImage(R.Image.icoEyeHide24.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -14, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 24), y: CGFloat(5), width: CGFloat(24), height: CGFloat(24))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        button.tintColor = R.Color.gray600
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
