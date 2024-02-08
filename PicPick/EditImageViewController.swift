//
//  EditImageViewController.swift
//  PicPick
//
//  Created by Jaeuk on 2/6/24.
//

import UIKit

import PicPick_Resource
import SnapKit
import CropViewController

class EditImageViewController: UIViewController {
    
    var originImage: UIImage = UIImage()
    var croppedRects: [CGRect] = [
        CGRect(x: 45, y: 46, width: 487, height: 325),
        CGRect(x: 45, y: 395, width: 487, height: 325),
        CGRect(x: 45, y: 745, width: 487, height: 325),
        CGRect(x: 45, y: 1094, width: 487, height: 325)]
    var croppedImages = [UIImage]()
    var editingImageIndex: Int?
    
    var croppedImageViews = [UIImageView]()
    
    lazy var originImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = R.Color.gray900
        image.image = originImage
        return image
    } ()
    
    lazy var bottomContentStack = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    } ()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        
        label.setTextWithLineHeight(text: NSLocalizedString("Edit Image Sub", comment: "Edit Image page Label Text"), lineHeight: PPFont.bodyLarge500.lineHeight)
        label.numberOfLines = 0
        label.font = PPFont.bodyLarge500.font
        label.textColor = R.Color.gray700
        
        return label
    } ()
    
    lazy var croppedImageStack = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    } ()
    
    lazy var nextButton = {
        let button = UIButton(configuration: .gray())
        button.setImage(R.Image.icoBtnLineArrowRight32.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitle("", for: .normal)
        button.configuration?.baseForegroundColor = R.Color.systemWhite
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = R.Color.gray900
        button.configuration?.contentInsets = .init(top: 13, leading: 13, bottom: 13, trailing: 13)
        button.makeShadow(.black, 0.12, CGSize(width: 0, height: 6), 24)
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Edit Image Title", comment: "Edit Image page navigationvar title")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : PPFont.titleLarge700.font]

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        view.addSubview(originImageView)
        view.addSubview(bottomContentStack)
        bottomContentStack.addArrangedSubview(subLabel)
        bottomContentStack.addArrangedSubview(croppedImageStack)
        bottomContentStack.addArrangedSubview(nextButton)
        
        originImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-192)
        }
        
        bottomContentStack.snp.makeConstraints {
            $0.height.equalTo(168)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        nextButton.snp.makeConstraints {
            $0.height.width.equalTo(58)
        }
        
        for croppedRect in croppedRects {
            if let image = cropImage(originImage, toRect: croppedRect) {
                croppedImages.append(image)
            }
        
        }
        
        nextButton.addTarget(self, action: #selector(saveImageInPhotos), for: .touchUpInside)
        
        for (index, croppedImage) in croppedImages.enumerated() {
            let imageView = UIImageView()
            imageView.image = croppedImage
            imageView.contentMode = .scaleAspectFit
            imageView.snp.makeConstraints {
                $0.width.height.equalTo(70)
            }
            imageView.isUserInteractionEnabled = true
            let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(imageTap)
            croppedImageViews.append(imageView)
            croppedImageStack.addArrangedSubview(croppedImageViews[index])
        }
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedView = tapGestureRecognizer.view as! UIImageView
        
        if let tappedImageIndex = croppedImageViews.firstIndex(of: tappedView) {
            editingImageIndex = tappedImageIndex
        }
        
        let vc = CropViewController(croppingStyle: .default, image: originImage)
        vc.doneButtonTitle = NSLocalizedString("Image Editor Continue", comment: "Image Editor Continue button title")
        vc.cancelButtonTitle = NSLocalizedString("Image Editor Cancel", comment: "Image Editor Cancel button title")
        vc.delegate = self
        vc.imageCropFrame = croppedRects[editingImageIndex!]
        present(vc, animated: true)
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage?
    {
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropRect)
        else {
            return nil
        }

        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    @objc
    func saveImageInPhotos() {
        croppedImages.forEach { image in
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
    }
}

extension EditImageViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        croppedImages[editingImageIndex!] = image
        croppedImageViews[editingImageIndex!].image = image
        croppedRects[editingImageIndex!] = cropRect
        editingImageIndex = nil
        cropViewController.dismiss(animated: true)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        editingImageIndex = nil
        cropViewController.dismiss(animated: true)

    }
    
}
