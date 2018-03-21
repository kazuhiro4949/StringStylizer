//
//  Operator.swift
//
//
//  Copyright (c) 2016 Kazuhiro Hayashi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
/**
 combine two NSAttributedString object
 
 
 - paramter left:NSAttributedString
 - paramter right:NSAttributedString
 
 - returns: NSAttributedString
 */
public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let concat = NSMutableAttributedString()
    concat.append(left)
    concat.append(right)
    return concat
}

/**
 append NSAttributedString object

 
 - paramter left:NSAttributedString
 - paramter right:NSAttributedString
 
 */
public func += (left: inout NSAttributedString, right: NSAttributedString) {
    left = left + right
}

/// combine two NSAttributedString and NSTextAttachment objects
///
/// - Parameters:
///   - left: NSAttributedString
///   - right: NSTextAttachment
/// - Returns: combinded NSAttributedString
public func + (left: NSAttributedString, right: NSTextAttachment) -> NSAttributedString {
    return left + NSAttributedString(attachment: right)
}

/// combine two NSTextAttachment and NSAttributedString objects
///
/// - Parameters:
///   - left: NSTextAttachment
///   - right: NSAttributedString
/// - Returns: combinded NSAttributedString
public func + (left: NSTextAttachment, right: NSAttributedString) -> NSAttributedString {
    return NSAttributedString(attachment: left) + right
}
