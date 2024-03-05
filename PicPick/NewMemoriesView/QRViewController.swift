//
//  QRViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/26/24.
//

import UIKit
import PhotosUI
import AVFoundation

import SnapKit
import PicPick_Resource
import PicPick_Util

class QRViewController: UIViewController {
    
    lazy var captureSession = AVCaptureSession()
    
    lazy var qrReaderView: PreviewView = PreviewView()
    
    lazy var fromPhotosButton: PPLineButton = {
        let button = PPLineButton(configuration: .bottom())
        button.setTitle(NSLocalizedString("QR From Photos Button", comment: "Bring Photo from Photo Library Button"), for: .normal)
        return button
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = R.Color.gray900
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : PPFont.titleLarge700.font,
            NSAttributedString.Key.foregroundColor : R.Color.gray900
        ]
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        captureSession.stopRunning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackBtnTitle()
        
        title = NSLocalizedString("QR Title", comment: "QR page navigationvar title")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : PPFont.titleLarge700.font]
        view.backgroundColor = .white
        
        view.addSubview(qrReaderView)
        view.addSubview(fromPhotosButton)
        
        qrReaderView.backgroundColor = .clear
        qrReaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(qrReaderView.snp.width)
        }
        
        fromPhotosButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        basicSetting()
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
    
    private func basicSetting() {
        
        // ✅ AVCaptureDevice : capture sessions 에 대한 입력(audio or video)과 하드웨어별 캡처 기능에 대한 제어를 제공하는 장치.
        // ✅ 즉, 캡처할 방식을 정하는 코드.
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            
            // ✅ 시뮬레이터에서는 카메라를 사용할 수 없기 때문에 시뮬레이터에서 실행하면 에러가 발생한다.
            fatalError("No video device found")
        }
        do {
            
            // 2️⃣ 적절한 inputs 설정
            // ✅ AVCaptureDeviceInput : capture device 에서 capture session 으로 media 를 제공하는 capture input.
            // ✅ 즉, 특정 device 를 사용해서 input 를 초기화.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // ✅ session 에 주어진 input 를 추가.
            captureSession.addInput(input)
            
            // 3️⃣ 적절한 outputs 설정
            // ✅ AVCaptureMetadataOutput : capture session 에 의해서 생성된 시간제한 metadata 를 처리하기 위한 capture output.
            // ✅ 즉, 영상으로 촬영하면서 지속적으로 생성되는 metadata 를 처리하는 output 이라는 말.
            let output = AVCaptureMetadataOutput()
            
            // ✅ session 에 주어진 output 를 추가.
            captureSession.addOutput(output)
            
            // ✅ AVCaptureMetadataOutputObjectsDelegate 포로토콜을 채택하는 delegate 와 dispatch queue 를 설정한다.
            // ✅ queue : delegate 의 메서드를 실행할 큐이다. 이 큐는 metadata 가 받은 순서대로 전달되려면 반드시 serial queue(직렬큐) 여야 한다.
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // ✅ 리더기가 인식할 수 있는 코드 타입을 정한다. 이 프로젝트의 경우 qr.
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // ✅ 카메라 영상이 나오는 layer 와 + 모양 가이드 라인을 뷰에 추가하는 함수 호출.
            setVideoLayer()
            
            // 4️⃣ startRunning() 과 stopRunning() 로 흐름 통제
            // ✅ input 에서 output 으로의 데이터 흐름을 시작
        }
        catch {
            print("error")
        }
    }
    
    // ✅ 카메라 영상이 나오는 layer 를 뷰에 추가
    private func setVideoLayer() {
//        // 영상을 담을 공간.
//        let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        // 카메라의 크기 지정
//        videoLayer.frame = qrReaderView.layer.bounds
//        // 카메라의 비율지정
//        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        qrReaderView.layer.addSublayer(videoLayer)
        
        qrReaderView.videoPreviewLayer.session = self.captureSession
        qrReaderView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
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

extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // ✅ caputure output object 가 새로운 metadata objects 를 보냈을 때 알린다.
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        // ✅ metadataObjects : 새로 내보낸 AVMetadataObject 인스턴스 배열이다.
        if let metadataObject = metadataObjects.first {
            
            // ✅ AVMetadataObject 는 추상 클래스이므로 이 배열의 object 는 항상 구체적인 하위 클래스의 인스턴스여야 한다.
            // ✅ AVMetadataObject 를 직접 서브클래싱해선 안된다. 대신 AVFroundation 프레임워크에서 제공하는 정의된 하위 클래스 중 하나를 사용해야 한다.
            // ✅ AVMetadataMachineReadableCodeObject : 바코드의 기능을 정의하는 AVMetadataObject 의 구체적인 하위 클래스. 인스턴스는 이미지에서 감지된 판독 가능한 바코드의 기능과 payload 를 설명하는 immutable object 를 나타낸다.
            // ✅ (참고로 이외에도 AVMetadataFaceObject 라는 감지된 단일 얼굴의 기능을 정의하는 subclass 도 있다.)
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else {
                return
            }
            
            // ✅ qr코드가 가진 문자열이 URL 형태를 띈다면 출력.(아무런 qr코드나 찍는다고 출력시키면 안되니까 여기서 분기처리 가능. )
            if stringValue.hasPrefix("http://") || stringValue.hasPrefix("https://")  {
                print(stringValue)
                
                // 4️⃣ startRunning() 과 stopRunning() 로 흐름 통제
                // ✅ input 에서 output 으로의 흐름 중지
                self.captureSession.stopRunning()
            }
        }
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
