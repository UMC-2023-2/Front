//
//  PPTextView.swift
//  PicPick
//
//  Created by Jaeuk on 2/13/24.
//

import UIKit

import PicPick_Resource

class PPTextView: UITextView, UITextViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var placeHolder: String?
    
    convenience init(placeHolder: String) {
        self.init()
        backgroundColor = .clear
        font = PPFont.bodyLarge500.font
        contentInset.left = 0
        textContainer.lineFragmentPadding = 0
        contentInset.top = 0
        self.placeHolder = placeHolder
        setTextViewPlaceholder()
        isScrollEnabled = false
        delegate = self
        textViewDidChange(self)
    }
    
    private func setTextViewPlaceholder() {
        if text == "" {
            text = placeHolder
            textColor = R.Color.gray600
        } else if text == placeHolder {
            text = ""
            textColor = R.Color.gray300
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewPlaceholder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            setTextViewPlaceholder()
        }
    }
}
