//
//  CarouselSlide.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

public struct CarouselSlide {
    public var image : UIImage
    public var title : String?
    public var description: String?
    
    public init(image: UIImage,
                title: String? = nil,
                description: String? = nil) {
        
        self.image = image
        self.title = title
        self.description = description
    }
}
