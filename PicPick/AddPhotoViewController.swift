//
//  AddPhotoViewController.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/02/07.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import Tabman
import Pageboy

class AddPhotoViewController: UIViewController {
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var segmentBtn : UISegmentedControl = {
        let segment = UISegmentedControl()
        
        segment.layer.cornerRadius = 20
        segment.backgroundColor = UIColor.white
        
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: "원본", at: 0, animated: true)
        segment.insertSegment(withTitle: "편집", at: 1, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray700,
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray900,
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        ], for: .selected)
        
        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        return segment
    }()
    
    
    
    private let underView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.gray900
        return view
    }()
    
    private let titleContent: UILabel = {
        let title = UILabel()
        title.text = "기록이 안된 사진들"
        title.font = UIFont(name: "Pretendard-Bold", size: 18)
        title.textColor = R.Color.gray900
        title.clipsToBounds = true
        return title
        
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 11
        return layout
    }()
    
    private lazy var cardContent: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageContainerCollectionViewCell.self, forCellWithReuseIdentifier: "ImageContainerCollectionViewCell")
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
    
    
    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentBtn.selectedSegmentIndex)
        
        // mainView 내용 업데이트
        switch segmentIndex {
        case 0: // "추억 앨범"
            updateMainViewForOriginPhoto()
        case 1: // "함께 앨범"
            updateMainViewForEditedPhoto()
        default:
            break
        }
        
        // underLineView 위치 업데이트
        let segmentWidth = segmentBtn.frame.width / 2
        let newLeadingDistance = segmentWidth * segmentIndex
        
        
        underView.snp.updateConstraints { make in
            make.leading.equalTo(segmentBtn.snp.leading).offset(newLeadingDistance)
            
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layoutIfNeeded()
            }
    }
    
    
    private func updateMainViewForOriginPhoto(){
        print("원본")
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(titleContent)
        titleContent.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
        
        contentView.addSubview(cardContent)
        cardContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func updateMainViewForEditedPhoto(){
        print("편집")
    }
    
    private func updateMainViewForNoPhoto(){
        print("모든 추억이 기록")
        
        //contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(titleContent)
        titleContent.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
        
        let textLabel = UILabel()
        
        textLabel.text = "모든 추억이 기록 되었습니다."
        textLabel.textColor = R.Color.gray700
        textLabel.font = UIFont(name: "Pretendard", size: 14)
        textLabel.textAlignment = .center
        
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
            make.height.equalTo(22)
        }
        
      
        // 이미지뷰 추가
        let imageView = UIImageView()
        imageView.image = R.Image.icoSearch46
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textLabel.snp.top).offset(-8) // text label과의 간격 조절
            make.height.equalTo(46)
            make.width.equalTo(imageView.snp.height)
        }
        
    }
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackBtnTitle()
        
        view.backgroundColor = R.Color.systemWhite
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "추억을 찾아드려요"
        navigationController?.navigationBar.tintColor = R.Color.gray900
        
        self.navigationItem.titleView = searchBar
        
        //
        self.view.addSubview(self.underView)
        
        self.view.addSubview(self.contentView)
       
        
        self.view.addSubview(self.segmentBtn)
        segmentBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(41)
            make.leading.trailing.equalToSuperview()
        }
        
        underView.snp.makeConstraints { make in
            make.bottom.equalTo(segmentBtn.snp.bottom).offset(2)
            make.height.equalTo(2)
            make.width.equalTo(segmentBtn.snp.width).dividedBy(segmentBtn.numberOfSegments)
            make.leading.equalTo(segmentBtn.snp.leading)
            
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(underView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
         
        //updateMainViewForOriginPhoto()
        updateMainViewForNoPhoto()
      
    }
    
    @objc func back() {
            self.navigationController?.popViewController(animated: true)
        }

    

}

extension AddPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of cells
        return 20 // or any other value based on your data
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageContainerCollectionViewCell", for: indexPath) as? ImageContainerCollectionViewCell else {
            return UICollectionViewCell()
        }
        // Configure your cell here
        // ...
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentViewWidth = contentView.frame.width
        let cellWidth = (contentViewWidth - 11) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Return the minimum line spacing
        return 11.0 // or any other value based on your preference
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(QRViewController(), animated: true)
    }
    
}


