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
    
    var tags:[String] = []
    
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
    
    lazy var keywords = {
        let view = DynamicCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout.init())
        
        if let flowLayout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.register(LabelsCollectionViewCell.self, forCellWithReuseIdentifier: LabelsCollectionViewCell.identifier)
        return view
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
        image.clipsToBounds = true
        
        return image
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroudImage)
        addSubview(memoriesLabel)
        addSubview(memoriesTextView)
        addSubview(keywordLabel)
        addSubview(keywords)
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
        
        keywords.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(keywordLabel.snp.bottom).offset(6)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(keywords.snp.bottom).offset(55)
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

extension NewMemoriesCollectionViewCell: UICollectionViewDelegate {
    
}

extension NewMemoriesCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = keywords.dequeueReusableCell(withReuseIdentifier: LabelsCollectionViewCell.identifier, for: indexPath) as! LabelsCollectionViewCell
        
        cell.chipLabel.text = tags[indexPath.item]
        cell.chipLabel.makeRound(radius: 13.25)
        return cell
    }
}


class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 6
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 6
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
