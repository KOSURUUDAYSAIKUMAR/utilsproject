//
//  CameraGallery.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit
import AssetsLibrary
import Photos
import PhotosUI

class CameraAndGalleryPermisson: NSObject{
    static let sharedInstance = CameraAndGalleryPermisson()
    
    public typealias imageComplition = ( _ image : UIImage?,_ strName : String?,_ error : Error?) -> Void
    var complation = {( _ image : UIImage?,_ strName : String?,_ error : Error?) -> Void in  }
    
    override init() {
        super.init()
    }
    
    func openCamara(_ vc : UIViewController,isEdit : Bool,_ imageComplition : @escaping imageComplition){
        
        self.checkPermissionForCamera { [weak self] isAuthorized in
            guard let `self` = self else { return }
            if isAuthorized {
                let picker = UIImagePickerController()
                picker.delegate = self
                if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                    picker.sourceType = UIImagePickerController.SourceType.camera
                    picker.allowsEditing = isEdit
                    picker.isEditing = isEdit
                    vc.present(picker, animated: true, completion: nil)
                    self.complation = imageComplition
                }
                else {
                    DispatchQueue.main.async {
                        imageComplition(nil,nil,nil)
                        AlertHelperModel.showAlert(title: "Utils", message: "You don't have camera", viewController: vc)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    AlertHelperModel.showAlertWithYesNo(title: "Utils", message: "Please allow access to camera permission.", button1: "Settings", noButton: "Cancel", viewController: vc) {
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: { (_ ) in
                        })
                    } noAction: {
                        
                    }
                    imageComplition(nil,nil,nil)
                }
            }
        }
    }
    
    func openPhotoLibrary(_ vc : UIViewController,isEdit : Bool,_ imageComplition : @escaping imageComplition){
        self.checkPhotoLibraryPermission { [weak self] isAuthorized in
            guard let `self` = self else { return }
            if isAuthorized {
                if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    picker.allowsEditing = isEdit
                    picker.isEditing = isEdit
                    
                    vc.present(picker, animated: true, completion: nil)
                    self.complation = imageComplition
                }else{
                    //no photoLibrary
                    DispatchQueue.main.async {
                        AlertHelperModel.showAlert(title: "Utils", message: "You don't have photoLibrary", viewController: vc)
                        imageComplition(nil,nil,nil)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    AlertHelperModel.showAlertWithYesNo(title: "Utils", message: "Please allow access to Photo Library permission.", button1: "Settings", noButton: "Cancel", viewController: vc) {
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: { (_ ) in
                        })
                    } noAction: {
                    }
                    imageComplition(nil,nil,nil)
                }
            }
        }
    }
    
    private func checkPermissionForCamera(authorizedRequested : @escaping (_ isAuthorized:Bool) -> Swift.Void) -> Void {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            DispatchQueue.main.async {
                authorizedRequested(true)
            }
        }
        else if AVCaptureDevice.authorizationStatus(for: .video) ==  .denied || AVCaptureDevice.authorizationStatus(for: .video) ==  .restricted {
            //restricted
            DispatchQueue.main.async {
                authorizedRequested(false)
            }
        }else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    DispatchQueue.main.async {
                        authorizedRequested(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        authorizedRequested(false)
                    }
                }
            })
        }
    }
    
    private func checkPhotoLibraryPermission(authorizedRequested : @escaping (_ isAuthorized:Bool) -> Swift.Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            //handle authorized status
            DispatchQueue.main.async {
                authorizedRequested(true)
            }
            break
        case .denied, .restricted :
            //handle denied status
            DispatchQueue.main.async {
                authorizedRequested(false)
            }
            break
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    // as above
                    DispatchQueue.main.async {
                        authorizedRequested(true)
                    }
                    break
                case .denied, .restricted:
                    DispatchQueue.main.async {
                        authorizedRequested(false)
                    }
                    break
                case .notDetermined:
                    // won't happen but still
                    break
                default:
                    DispatchQueue.main.async {
                        authorizedRequested(true)
                    }
                    break;
                }
            }
            break
        default:
            DispatchQueue.main.async {
                authorizedRequested(true)
            }
            break;
        }
    }
    
    
    
}

extension CameraAndGalleryPermisson : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker .dismiss(animated: true, completion: nil)
        var image : UIImage?
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = img
        }else if let originalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = originalImg
        }else{
            image = nil
        }
        var strImageName = ""
        if (info[.imageURL] as? NSURL) != nil {
            let imageUrl = info[.imageURL] as! NSURL
            let imageName :String! = imageUrl.pathExtension
            strImageName = "\(Int(Date().timeIntervalSince1970))."
            strImageName = strImageName.appending(imageName)
        }else{
            strImageName = "\(Int(Date().timeIntervalSince1970)).png"
        }
        guard image != nil else {
            DispatchQueue.main.async {
                self.complation(nil,nil,"enable to get image" as? Error)
            }
            return
        }
        DispatchQueue.main.async {
            self.complation(image,strImageName,nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker .dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.complation(nil,nil,nil)
        }
    }
}
