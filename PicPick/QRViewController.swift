//
//  QRViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/26/24.
//

import UIKit
import PhotosUI

import SnapKit

class QRViewController: UIViewController {
    
    lazy var qrReaderView: QRReaderView = QRReaderView()
    
    lazy var fromPhotosButton: PPLineButton = {
        let button = PPLineButton(configuration: .bottom())
        button.setTitle(NSLocalizedString("QR From Photos Button", comment: "Bring Photo from Photo Library Button"), for: .normal)
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("QR Title", comment: "QR page navigationvar title")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : PPFont.titleLarge700.font]
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        
        view.addSubview(qrReaderView)
        view.addSubview(fromPhotosButton)
        
        qrReaderView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        fromPhotosButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        // Do any additional setup after loading the view.
        
        fromPhotosButton.addTarget(self, action: #selector(fromPhotosBtnDidTap(_:)), for: .touchUpInside)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc
    func fromPhotosBtnDidTap(_ sender: PPLineButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
}

extension QRViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                     if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            let editImageVC = EditImageViewController()
                            editImageVC.originImage = image
                            self.navigationController?.pushViewController(editImageVC, animated: true)
                        }
                     }
                  })
        }
    }
    
    
}
