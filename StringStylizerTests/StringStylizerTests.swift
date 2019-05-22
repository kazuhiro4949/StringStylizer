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
    
    func testOperatorPlus() {
        let str = "String".stylize().attr + "Stylizer".stylize().attr
        let expected = NSAttributedString(string: "StringStylizer")
        XCTAssert(str.isEqual(to: expected), "has + operator attributed")
    }

    func testOperatorPlusEqual() {
        var str = "String".stylize().attr
        str += "Stylizer".stylize().attr
        let expected = NSAttributedString(string: "StringStylizer")
        XCTAssert(str.isEqual(to: expected), "has += operator attributed")
    }
    
    func testColor() {
        let str = "StringStylizer".stylize().color(.white).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.foregroundColor: UIColor.white])
        XCTAssert(str.isEqual(to: expected), "has color attributed")
    }
    
    func testFontAndSize() {
        let str = "StringStylizer".stylize().font(.Helvetica).size(17).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.font: UIFont(name: "Helvetica", size: 17)!])
        XCTAssert(str.isEqual(to: expected), "has font and size attributed")
    }
    
    func testBackground() {
        let str = "StringStylizer".stylize().background(0x000000).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.backgroundColor: rgb(0x000000, alpha: 1.0)])
        XCTAssert(str.isEqual(to: expected), "has background attributed")
    }
    
    func testkern() {
        let str = "StringStylizer".stylize().kern(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.kern: 1])
        XCTAssert(str.isEqual(to: expected), "has kern attributed")
    }
    
    func testUnderline() {
        #if swift(>=4.2)
        let str = "StringStylizer".stylize().underline(.single).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.underlineStyle:  NSUnderlineStyle.single.rawValue])
        #else
        let str = "StringStylizer".stylize().underline(.styleSingle).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.underlineStyle:  NSUnderlineStyle.styleSingle.rawValue])
        #endif
        XCTAssert(str.isEqual(to: expected), "has underline attributed")
    }

    func testUnderlineNoneParam() {
        let str = "StringStylizer".stylize().underline().attr
        #if swift(>=4.2)
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.underlineStyle:  NSUnderlineStyle.single.rawValue])
        #else
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.underlineStyle:  NSUnderlineStyle.styleSingle.rawValue])
        #endif
        XCTAssert(str.isEqual(to: expected), "has underline attributed")
    }

    func testStrokeParam() {
        let str = "StringStylizer".stylize().stroke(color: .white).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.strokeColor:  UIColor.white, .strokeWidth: 1.0])
        XCTAssert(str.isEqual(to: expected), "has stroke attributed")
    }
    
    func testStrikeThroughParam() {
        #if swift(>=4.2)
        let str = "StringStylizer".stylize().strikeThrough(.double).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.strikethroughStyle:  NSUnderlineStyle.double.rawValue])
        #else
        let str = "StringStylizer".stylize().strikeThrough(.styleDouble).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.strikethroughStyle:  NSUnderlineStyle.styleDouble.rawValue])
        #endif
        XCTAssert(str.isEqual(to: expected), "has strikeThrough attributed")
    }
    
    func testStrikeThroughBlankParam() {
        let str = "StringStylizer".stylize().strikeThrough().attr
        #if swift(>=4.2)
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.strikethroughStyle:  NSUnderlineStyle.single.rawValue])
        #else
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.strikethroughStyle:  NSUnderlineStyle.styleSingle.rawValue])
        #endif
        XCTAssert(str.isEqual(to: expected), "has strikeThrough attributed")
    }
    
    func testShadowParam() {
        let shadow = NSShadow()
        let str = "StringStylizer".stylize().shadow(shadow).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.shadow:  shadow])
        XCTAssert(str.isEqual(to: expected), "has shadow attributed")
    }
    
    func testShadowPropertyParam() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10), color: UIColor.red, blurRadius: 1.0).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 10, height: 10)
        shadow.shadowColor = UIColor.red
        shadow.shadowBlurRadius = 1.0
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.shadow:  shadow])
        XCTAssert(str.isEqual(to: expected), "has shadow attributed")
    }

    
    func testShadowPropertyParamNoAplphaAndBlurRadius() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10), color: UIColor.red).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 10, height: 10)
        shadow.shadowColor = UIColor.red
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.shadow:  shadow])
        XCTAssert(str.isEqual(to: expected), "has shadow attributed")
    }
    
    func testShadowPropertyParamNoAplphaAndBlurRadiusAndColor() {
        let str = "StringStylizer".stylize().shadow(offset: (10, 10)).attr
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 10, height: 10)
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.shadow:  shadow])
        XCTAssert(str.isEqual(to: expected), "has shadow attributed")
    }
    
    func testLigatureParam() {
        let str = "StringStylizer".stylize().ligature(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.ligature:  1])
        XCTAssert(str.isEqual(to: expected), "has ligature attributed")
    }
    
    func testBaselineParam() {
        let str = "StringStylizer".stylize().baselineOffset(1).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.baselineOffset:  1])
        XCTAssert(str.isEqual(to: expected), "has baselineOffset attributed")
    }
    
    func testLinkParam() {
        let url = URL(string: "http://test.com")!
        let str = "StringStylizer".stylize().link(url).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.link: url])
        XCTAssert(str.isEqual(to: expected), "has link attribute")
    }
    
    func testParagraphParam() {
        let paragraph = NSParagraphStyle()
        let str = "StringStylizer".stylize().paragraph(paragraph).attr
        let expected = NSAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: paragraph])
        XCTAssert(str.isEqual(to: expected), "has color attributed")
    }
    
    func testPartialRange() {
        let str = "StringStylizer".stylize().range(5..<UInt.max).color(.white).attr
        
        let expected = NSMutableAttributedString(string: "StringStylizer")
        expected.addAttributes([.foregroundColor: UIColor.white], range: NSRange(5..<str.length))
        XCTAssert(str.isEqual(to: expected), "has correct partial range")
    }

    func testPartialSearch() {
        let str = "StringStylizer".stylize().search("ring").color(.white).attr
        
        let expected = NSMutableAttributedString(string: "StringStylizer")
        expected.addAttributes([.foregroundColor: UIColor.white], range: NSRange(2..<6))
        XCTAssert(str.isEqual(to: expected), "has correct partial range")
    }
    
    func testTwoPartialRanges() {
        let str = "StringStylizer".stylize()
            .range(5..<UInt.max).color(.white)
            .range(1..<4).size(14).attr
        
        let expected = NSMutableAttributedString(string: "StringStylizer")
        expected.addAttributes(
            [.foregroundColor: UIColor.white],
            range: NSRange(5..<str.length)
        )
        expected.addAttributes(
            [.font: UIFont.systemFont(ofSize: 14)],
            range: NSRange(1..<4)
        )

        XCTAssert(str.isEqual(to: expected), "has correct partial range")
    }
    
    func testConcatenateTwoAttributedString() {
        let str = "String"  .stylize().range(5..<UInt.max).color(.white).attr +
                  "Stylizer".stylize().range(1..<4).size(14).attr
        
        let expectedHead = NSMutableAttributedString(string: "String")
        expectedHead.addAttributes(
            [.foregroundColor: UIColor.white],
            range: NSRange(5..<"String".count)
        )
        let expectedTail = NSMutableAttributedString(string: "Stylizer")
        expectedTail.addAttributes(
            [.font: UIFont.systemFont(ofSize: 14)],
            range: NSRange(1..<4)
        )
        expectedHead.append(expectedTail)
        
        XCTAssert(str.isEqual(to: expectedHead), "has joind Attribute")
    }
    
    func testParagraphAlignment() {
        let str = "StringStylizer".stylize().paragraphAlignment(.right).attr
        
        let style = NSMutableParagraphStyle()
        style.alignment = .right
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])

        XCTAssert(str.isEqual(to: expcted), "has paragraph Alinment")
    }
    
    func testParagraphIndent() {
        let str = "StringStylizer".stylize().paragraphIndent(firstLineHead: 10, tail: 10, otherHead: 10).attr
        
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 10
        style.headIndent = 10
        style.tailIndent = 10
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])
        XCTAssert(str.isEqual(to: expcted), "has paragraph Indent")
    }
    
    func testParagraphLineBreak() {
        let str = "StringStylizer".stylize().paragraphLineBreak(.byCharWrapping).attr
        
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byCharWrapping
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])
        XCTAssert(str.isEqual(to: expcted), "has paragraph line break")
    }
    
    func testParagraphLineHeight() {
        let str = "StringStylizer".stylize().paragraphLineHeight(maximum: 10, minimum: 10, multiple: 1.0).attr
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 10
        style.minimumLineHeight = 10
        style.lineHeightMultiple = 1.0
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])
        XCTAssert(str.isEqual(to: expcted), "has paragraph line height")
    }

    func testParagraphLineSpace() {
        let str = "StringStylizer".stylize().paragraphLineSpacing(after: 10, before: 10).attr
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.paragraphSpacingBefore = 10
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])
        XCTAssert(str.isEqual(to: expcted), "has paragraph spacing before")
    }

    func testParagraphBaseWritingDirection() {
        let str = "StringStylizer".stylize().paragraphBaseWritingDirection(NSWritingDirection.rightToLeft).attr
        
        let style = NSMutableParagraphStyle()
        style.baseWritingDirection = .rightToLeft
        let expcted = NSMutableAttributedString(string: "StringStylizer", attributes: [.paragraphStyle: style])
        XCTAssert(str.isEqual(to: expcted), "has paragraph Indent")
    }
    
    func testOptionalString() {
        let nothing: String? = nil
        let something = "StringStylizer"
        
        let combined = (
            nothing.stylize().attr +
            something.stylize().attr
        )
        
        let expected = NSAttributedString(string: "StringStylizer")
        XCTAssert(combined.isEqual(expected), "optional StringStylized strings do not add any content to the resulting NSAttributedString")
    }
    
    // MARK:- private
    fileprivate func rgb(_ rgb: UInt, alpha: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
