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
        XCTAssert(str.isEqualToAttributedString(expected), "has font and size attributed")
    }
    
    func testBackground() {
        let str = "StringStylizer".stylize().background(0x000000).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSBackgroundColorAttributeName: rgb(0x000000, alpha: 1.0)])
        XCTAssert(str.isEqualToAttributedString(expected), "has background attributed")
    }
    
    func testKarn() {
        let str = "StringStylizer".stylize().karn(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSKernAttributeName: 1])
        XCTAssert(str.isEqualToAttributedString(expected), "has karn attributed")
    }
    
    func testUnderline() {
        let str = "StringStylizer".stylize().underline(.StyleSingle).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSUnderlineStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has underline attributed")
    }

    func testUnderlineNoneParam() {
        let str = "StringStylizer".stylize().underline().attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSUnderlineStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has underline attributed")
    }

    func testStrokeParam() {
        let str = "StringStylizer".stylize().stroke(color: .whiteColor()).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrokeColorAttributeName:  UIColor.whiteColor(),
            NSStrokeWidthAttributeName: 1.0])
        XCTAssert(str.isEqualToAttributedString(expected), "has stroke attributed")
    }
    
    func testStrokeThroghParam() {
        let str = "StringStylizer".stylize().strokeThrogh(.StyleDouble).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrikethroughStyleAttributeName:  NSUnderlineStyle.StyleDouble.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has strokeThrogh attributed")
    }
    
    func testStrokeThroghBlankParam() {
        let str = "StringStylizer".stylize().strokeThrogh().attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSStrikethroughStyleAttributeName:  NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssert(str.isEqualToAttributedString(expected), "has strokeThrogh attributed")
    }
    
    func testShadowParam() {
        let shadow = NSShadow()
        let str = "StringStylizer".stylize().shadow(shadow).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSShadowAttributeName:  shadow])
        XCTAssert(str.isEqualToAttributedString(expected), "has shadow attributed")
    }
    
    func testShadowPropertyParam() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10), color: UIColor.redColor(), blurRadius: 1.0).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSizeMake(10, 10)
        shadow.shadowColor = UIColor.redColor()
        shadow.shadowBlurRadius = 1.0
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSShadowAttributeName:  shadow])
        XCTAssert(str.isEqualToAttributedString(expected), "has shadow attributed")
    }

    
    func testShadowPropertyParamNoAplphaAndBlurRadius() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10), color: UIColor.redColor()).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSizeMake(10, 10)
        shadow.shadowColor = UIColor.redColor()
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSShadowAttributeName:  shadow])
        XCTAssert(str.isEqualToAttributedString(expected), "has shadow attributed")
    }
    
    func testShadowPropertyParamNoAplphaAndBlurRadiusAndColor() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10)).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSizeMake(10, 10)
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSShadowAttributeName:  shadow])
        XCTAssert(str.isEqualToAttributedString(expected), "has shadow attributed")
    }
    
    func testLigetureParam() {
        let str = "StringStylizer".stylize().ligeture(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSLigatureAttributeName:  1])
        XCTAssert(str.isEqualToAttributedString(expected), "has ligeture attributed")
    }
    
    func testBaselineParam() {
        let str = "StringStylizer".stylize().baselineOffset(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSBaselineOffsetAttributeName:  1])
        XCTAssert(str.isEqualToAttributedString(expected), "has baselineOffset attributed")
    }
    
    func testLinkParam() {
        let url = NSURL(string: "")!
        let str = "StringStylizer".stylize().link(url).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSLinkAttributeName: url])
        XCTAssert(str.isEqualToAttributedString(expected), "has link attribute")
    }
    
    func testParagraphParam() {
        let paragraph = NSParagraphStyle()
        let str = "StringStylizer".stylize().paragraph(paragraph).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: paragraph])
        XCTAssert(str.isEqualToAttributedString(expected), "has color attributed")
    }
    
    func testPartialRange() {
        let str = "StringStylizer".stylize().range(5..<UInt.max).color(.whiteColor()).attr
        
        let expected = NSMutableAttributedString(string: "StringStylizer")
        expected.addAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSRange(5..<str.length))
        XCTAssert(str.isEqualToAttributedString(expected), "has correct partial range")
    }
    
    func testTwoPartialRanges() {
        let str = "StringStylizer".stylize()
            .range(5..<UInt.max).color(.whiteColor())
            .range(1..<4).size(14).attr
        
        let expected = NSMutableAttributedString(string: "StringStylizer")
        expected.addAttributes(
            [NSForegroundColorAttributeName: UIColor.whiteColor()],
            range: NSRange(5..<str.length)
        )
        expected.addAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(14)],
            range: NSRange(1..<4)
        )

        XCTAssert(str.isEqualToAttributedString(expected), "has correct partial range")
    }
    
    func testConcatenateTwoAttributedString() {
        let str = "String"  .stylize().range(5..<UInt.max).color(.whiteColor()).attr +
                  "Stylizer".stylize().range(1..<4).size(14).attr
        
        let expectedHead = NSMutableAttributedString(string: "String")
        expectedHead.addAttributes(
            [NSForegroundColorAttributeName: UIColor.whiteColor()],
            range: NSRange(5..<"String".characters.count)
        )
        let expectedTail = NSMutableAttributedString(string: "Stylizer")
        expectedTail.addAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(14)],
            range: NSRange(1..<4)
        )
        expectedHead.appendAttributedString(expectedTail)
        
        XCTAssert(str.isEqualToAttributedString(expectedHead), "has joind Attribute")
    }
    
    func testParagraphAlignment() {
        let str = "StringStylizer".stylize().paragraphAlignment(.Right).attr
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Right
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])

        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph Alinment")
    }
    
    func testParagraphIndent() {
        let str = "StringStylizer".stylize().paragraphIndent(firstLineHead: 10, tail: 10, otherHead: 10).attr
        
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 10
        style.headIndent = 10
        style.tailIndent = 10
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])
        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph Indent")
    }
    
    func testParagraphLineBreak() {
        let str = "StringStylizer".stylize().paragraphLineBreak(.ByCharWrapping).attr
        
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .ByCharWrapping
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])
        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph line break")
    }
    
    func testParagraphLineHeight() {
        let str = "StringStylizer".stylize().paragraphLineHeight(maximum: 10, minimum: 10, multiple: 1.0).attr
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 10
        style.minimumLineHeight = 10
        style.lineHeightMultiple = 1.0
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])
        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph line height")
    }

    func testParagraphLineSpace() {
        let str = "StringStylizer".stylize().paragraphLineSpacing(after: 10, before: 10).attr
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.paragraphSpacingBefore = 10
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])
        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph spacing before")
    }

    func testParagraphBaseWritingDirection() {
        let str = "StringStylizer".stylize().paragraphBaseWritingDirection(NSWritingDirection.RightToLeft).attr
        
        let style = NSMutableParagraphStyle()
        style.baseWritingDirection = .RightToLeft
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [NSParagraphStyleAttributeName: style])
        XCTAssert(str.isEqualToAttributedString(expcted), "has paragraph Indent")
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
