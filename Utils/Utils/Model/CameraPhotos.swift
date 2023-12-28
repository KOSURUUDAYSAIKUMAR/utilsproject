//
//  CameraPhotos.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit
import AssetsLibrary
import Photos
import PhotosUI

class CamaraPhotosAndFileManager: NSObject{
    
    static let sharedInstance = CamaraPhotosAndFileManager()
    
    public typealias imageComplition = ( _ image : UIImage?,_ strName : String?,_ error : Error?) -> Void
    var complation = {( _ image : UIImage?,_ strName : String?,_ error : Error?) -> Void in  }
    
    public typealias fileComplition = ( _ file : Data?,_ fileUrl : URL?,_ error : Error?) -> Void
    var complationFile = {( _ file : Data?,_ fileUrl : URL?,_ error : Error?) -> Void in  }

    override init() {
        super.init()
    }
    
    func openCamaraAndPhotoLibrary(_ viewController : UIViewController, type: Int, isEdit : Bool = true,_ imageComplition : @escaping imageComplition,_ fileComplition : @escaping fileComplition) {
        if type == 0 {
            CameraAndGalleryPermisson.sharedInstance.openCamara(viewController, isEdit: isEdit, imageComplition)
        } else if type == 1 {
            CameraAndGalleryPermisson.sharedInstance.openPhotoLibrary(viewController, isEdit: isEdit, imageComplition)
        }
    }
}

extension CamaraPhotosAndFileManager : UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .open,
            let url = urls.first, url.startAccessingSecurityScopedResource()
        else {
            return
        }
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        do {
            let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                self.complationFile(data,url,nil)
            }
        }
        catch {
            DispatchQueue.main.async {
                self.complationFile(nil,nil,error)
            }
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL){
        guard controller.documentPickerMode == .open, url.startAccessingSecurityScopedResource()
        else {
            return
        }
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        do {
            let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                self.complationFile(data,url,nil)
            }
        }
        catch {
            DispatchQueue.main.async {
                self.complationFile(nil,nil,error)
            }
        }
    }
}
