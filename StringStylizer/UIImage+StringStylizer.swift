//
//  UIImage+StringStylizer.swift
//  StringStylizer
//
//  Created by kahayash on 2018/03/21.
//  Copyright © 2018年 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// Instantiate NSTextAttachment from the uiimage object.
    ///
    /// - Parameter size: attachmented image size
    /// - Returns: NSTextAttachment
    func textAttachment(with size: CGSize) -> NSTextAttachment {
        let textAttachment = NSTextAttachment()
        textAttachment.image = self
        textAttachment.bounds = CGRect(origin: .zero, size: size)
        return textAttachment
    }
    
    
    /// Instantiate NSTextAttachment from the uiimage object.
    ///
    /// - Parameters:
    ///   - width: attachmented image width
    ///   - height:  attachmented image height
    /// - Returns: NSTextAttachment
    func textAttachment(_ width: CGFloat, _ height: CGFloat) -> NSTextAttachment {
        let size = CGSize(width: width, height: height)
        return textAttachment(with: size)
    }
}
