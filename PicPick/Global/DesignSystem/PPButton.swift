//
//  PPButton.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

import PicPick_Resource

class PPButton: UIButton {

    enum Color: String {
        case black = "Black"
        case white = "White"
    }

    var text: String? = nil {
        didSet {
            configuration?.title = text
        }
    }
    
    var isDisabled: Bool = false {
        didSet {
            self.isEnabled = !isDisabled
            setButtonColor()
        }
    }
    
    var isBlack: Bool = true {
        didSet {
            setButtonColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
    }
    
    convenience init(color: Color, disable: Bool = false) {
        self.init()
        switch color {
        case .black:
            isBlack = true
        case .white:
            isBlack = false
        }
        isDisabled = disable
        setButtonColor()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConfig() {
        configuration = UIButton.Configuration.gray()
        configuration?.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        configuration?.cornerStyle = .capsule
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium700.font
            return outgoing
        }
        titleLabel?.textAlignment = .center
    }
        
    private func setButtonColor() {
        let disableBackgroundColor = isBlack ? R.Color.gray700 : R.Color.gray300
        let enabledBackgroundColor = isBlack ? R.Color.systemWhite : R.Color.gray900
        
        let disableTextColor = isBlack ? R.Color.gray800 : R.Color.gray600
        let enabledTextColor = isBlack ? R.Color.gray900 : R.Color.gray300
        
        configuration?.baseBackgroundColor = isDisabled ? disableBackgroundColor : enabledBackgroundColor
        configuration?.baseForegroundColor = isDisabled ? disableTextColor : enabledTextColor
    }
}
