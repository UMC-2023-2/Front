//
//  LabelsCollectionViewCell.swift
//  PicPick
//
//  Created by Jaeuk on 2/22/24.
//

import UIKit

import PicPick_Resource
import PicPick_Util

class LabelsCollectionViewCell: UICollectionViewCell {
    static let identifier = "LabelsCollectionViewCell"
    
    lazy var chipLabel = {
        let label = PaddingLabel()
        label.layer.borderWidth = 1
        label.layer.borderColor = R.Color.gray600.cgColor
        label.textColor = R.Color.gray400
        label.font = PPFont.captionLarge600.font
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    } ()
    
    lazy var chipBackView = {
        let view = UIView()
        view.addSubview(chipLabel)
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(chipLabel)
        
        chipLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 6.0
    @IBInspectable var bottomInset: CGFloat = 6.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
