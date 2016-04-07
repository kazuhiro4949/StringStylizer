//
//  StringStylizerTests.swift
//  StringStylizerTests
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

import XCTest
@testable import StringStylizer

class StringStylizerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColor() {
        let str = "StringStylizer".stylize().color(.whiteColor()).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testFontAndSize() {
        let str = "StringStylizer".stylize().font(.Helvetica).size(17).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 17)!])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testBackground() {
        let str = "StringStylizer".stylize().background(0x000000).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSBackgroundColorAttributeName: rgb(0x000000, alpha: 1.0)])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testKarn() {
        let str = "StringStylizer".stylize().karn(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSKernAttributeName: 1])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testUnderline() {
        let str = "StringStylizer".stylize().underline(.StyleSingle).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSUnderlineStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }

    func testUnderlineNoneParam() {
        let str = "StringStylizer".stylize().underline().attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSUnderlineStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }

    func testStrokeParam() {
        let str = "StringStylizer".stylize().stroke(color: .whiteColor()).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrokeColorAttributeName:  UIColor.whiteColor(),
            NSStrokeWidthAttributeName: 1.0])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testStrokeThroghParam() {
        let str = "StringStylizer".stylize().strokeThrogh(.StyleDouble).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrikethroughStyleAttributeName:  NSUnderlineStyle.StyleDouble.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testStrokeThroghBlankParam() {
        let str = "StringStylizer".stylize().strokeThrogh().attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrikethroughStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testShadowParam() {
        let shadow = NSShadow()
        let str = "StringStylizer".stylize().shadow(shadow).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSShadowAttributeName:  shadow])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testLigetureParam() {
        let str = "StringStylizer".stylize().ligeture(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSLigatureAttributeName:  1])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testBaselineParam() {
        let str = "StringStylizer".stylize().baselineOffset(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSBaselineOffsetAttributeName:  1])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testLinkParam() {
        let url = NSURL(string: "")!
        let str = "StringStylizer".stylize().link(url).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSLinkAttributeName: url])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testParagraphParam() {
        let paragraph = NSParagraphStyle()
        let str = "StringStylizer".stylize().paragraph(paragraph).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: paragraph])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    // MARK:- private
    private func rgb(rgb: UInt, alpha: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
