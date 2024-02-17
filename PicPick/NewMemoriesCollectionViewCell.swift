//
//  NewMemoriesCollectionViewCell.swift
//  PicPick
//
//  Created by Jaeuk on 2/13/24.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import SnapKit

class NewMemoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewMemoriesCollectionViewCell"
    
    lazy var memoriesLabel = {
        let label = UILabel()
        label.text = NSLocalizedString("New Memories Write Memory Label", comment: "New Memories Write Memory Label")
        label.font = PPFont.titleMedium500.font
        label.textColor = R.Color.gray300
        return label
    } ()
    
    lazy var memoriesTextView = {
        let textView = PPTextView(placeHolder: NSLocalizedString("New Memories Write Memory Placeholder", comment: "New Memories Write Memory Placeholder"))
        
        return textView
    } ()
    
    lazy var keywordLabel = {
        let label = UILabel()
        label.text = NSLocalizedString("New Memories Keyword Label", comment: "New Memories Keyword Label")
        label.font = PPFont.titleMedium500.font
        label.textColor = R.Color.gray300
        return label
    } ()
    
    lazy var dateLabel = {
        let label = UILabel()
        label.text = NSLocalizedString("New Memories Date Label", comment: "New Memories Date Label")
        label.font = PPFont.titleMedium500.font
        label.textColor = R.Color.gray300
        return label
    } ()
    
    lazy var backgroudImage = {
        let image = UIImageView()
        image.image = R.Image.imgWelcomeBackground
        image.contentMode = .scaleAspectFill
        
        let dimd = UIView()
        dimd.backgroundColor = R.Color.dimdDark
        
        image.addSubview(dimd)
        dimd.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return image
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroudImage)
        addSubview(memoriesLabel)
        addSubview(memoriesTextView)
        addSubview(keywordLabel)
        addSubview(dateLabel)
        
        backgroudImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        memoriesLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(36)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        memoriesTextView.snp.makeConstraints {
            $0.top.equalTo(memoriesLabel.snp.bottom).offset(12)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(memoriesTextView.snp.bottom).offset(55)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(55)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func doneBtnClicked (sender: Any) {
            //click action...
            endEditing(true)
    }
    
}
