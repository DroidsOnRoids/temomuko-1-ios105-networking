//
//  UIImageExtension.swift
//  Snappy
//
//  Created by Bartosz Górka on 05/04/17.
//  Copyright © 2017 Droids on Roids. All rights reserved.
//

import UIKit

extension UIImage {
    func fixImageOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let imageFromContext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageFromContext ?? UIImage()
    }
}
