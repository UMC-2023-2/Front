//
//  NewMemoriesViewController.swift
//  PicPick
//
//  Created by Jaeuk on 2/13/24.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import SnapKit

class NewMemoriesViewController: UIViewController {
    
    var images: [UIImage]?
    
    lazy var nextButton = {
        let button = PPWhiteButton(buttonStyle: .bottom)
        button.setTitle(NSLocalizedString("New Memories Choose Album", comment: "New Memories Choose Album"), for: .normal)
        button.isEnabled = false
        return button
    } ()
    
    lazy var pageCtrl = {
        let ctrl = UIPageControl()
        ctrl.numberOfPages = images?.count ?? 0
        ctrl.currentPage = 0
        ctrl.allowsContinuousInteraction = false
        return ctrl
    } ()
    
    lazy var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.decelerationRate = .fast
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    } ()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = R.Color.systemWhite
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : PPFont.titleLarge700.font,
            NSAttributedString.Key.foregroundColor : R.Color.gray300
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = R.Color.gray900
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : PPFont.titleLarge700.font,
            NSAttributedString.Key.foregroundColor : R.Color.gray900
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.Color.gray600
        
        removeBackBtnTitle()
        title = NSLocalizedString("New Memories Title", comment: "New Memories Page Title")

        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(pageCtrl)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        pageCtrl.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewMemoriesCollectionViewCell.self, forCellWithReuseIdentifier: NewMemoriesCollectionViewCell.identifier)
        
        addTapGesture()
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

}

extension NewMemoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewMemoriesCollectionViewCell.identifier, for: indexPath) as? NewMemoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroudImage.image = images![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? NewMemoriesCollectionViewCell {
//            
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

extension NewMemoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = view.frame.width + 1
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
        view.endEditing(true)
        pageCtrl.currentPage = Int(index)
    }
}
