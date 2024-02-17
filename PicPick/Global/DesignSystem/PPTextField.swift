//
//  PPTextField.swift
//  PicPick
//
//  Created by Jaeuk on 1/29/24.
//

import UIKit

import SnapKit
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
        rightView?.frame = rightViewRect(forBounds: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 13).offsetBy(dx: -8, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 13).offsetBy(dx: -8, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 13).offsetBy(dx: -8, dy: 0)
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
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        button.tintColor = R.Color.gray600
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = textRect(forBounds: bounds)
        rect.size.width = 34
        rect.origin.x = bounds.size.width - rect.size.width
        return rect
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return rightViewRect(forBounds: bounds)
    }
}
