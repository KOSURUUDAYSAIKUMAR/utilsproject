//
//  PhotoLocationTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit
import CoreLocation

@objc protocol cameraGalleryLocationDelegate: AnyObject {
    @objc func cameraGalleryLocationHandler(tag: Int)
}

class PhotoLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var locationButtonOutlet: UIButton!
    weak var delegate : cameraGalleryLocationDelegate?
    // the view controller that presents the Image picker
    weak var parentViewController: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        locationButtonOutlet.addBorderAndColor(color: UIColor.systemBlue, width: 1, corner_radius: 5, clipsToBounds: true)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func galleryCameraLocationHandler(_ sender: UIButton) {
        if sender.tag == 2 {
            LocationManager.shared.getLocation { [self] (location:CLLocation?, error:NSError?) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let location = location else {
                    return
                }
                self.latLabel.text = "Latitude: " + "\(location.coordinate.latitude)"
                longLabel.text = "Longitude: " + location.coordinate.longitude.description
                print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
            }
            return
        }
        CamaraPhotosAndFileManager.sharedInstance.openCamaraAndPhotoLibrary(parentViewController!, type: sender.tag, { [self] (image, strImageName, error) in
            guard let imgProfile = image,let imageName = strImageName else{
                return
            }
            if sender.tag == 0 {
                cameraImageView.image = imgProfile
            } else if sender.tag == 1 {
                galleryImageView.image = imgProfile
            }
//            print(" imgProfile ",String(describing: imgProfile))
//            print(" imageName ",String(describing: imageName))
        }) {(data, url, error) in
            guard let data = data,let url = url else{return}
            print(" data ",String(describing: data))
            print(" url ",String(describing: url))
        }
        delegate?.cameraGalleryLocationHandler(tag: sender.tag)
    }
}
