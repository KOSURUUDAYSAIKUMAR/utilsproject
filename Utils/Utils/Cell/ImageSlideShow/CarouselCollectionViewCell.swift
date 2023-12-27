//
//  CarouselCollectionViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 27/12/23.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
     
    @IBOutlet weak var image: UIImageView! = {
        let imageView = UIImageView()
        imageView.addBlackGradientLayer()
        return imageView
    }()
    
    @IBOutlet weak var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBOutlet weak var titleLabel: UILabel! = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "carousel_slide_default_Cell"
    
    public var slide : CarouselSlide? {
        didSet {
            guard let slide = slide else {
                print("ZKCarousel is unable to parse the ZKCarouselSlide that was provided.")
                return
            }
            
            parseData(forSlide: slide)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
       
        image.contentMode = .scaleToFill
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        // Initialization code
    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: - Actions
    private func setup() {
        backgroundColor = .clear
        clipsToBounds = true
    }
    
    private func parseData(forSlide slide: CarouselSlide) {
        image.image = slide.image
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
}
