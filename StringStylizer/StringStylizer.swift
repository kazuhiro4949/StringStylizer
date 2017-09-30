//
//  StringSerializer.swift
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
 Type safely builder class for NSAttributedString. 
 
 It makes NSAttributedString more intitive by wrapping method chains and operators.
 
 #### Usage
 when you convert String to NSAttributedString which has some colors, sizes and fonts, you can write it in a linear manner.
 
 ```
 let label = UILabel(frame: CGRectMake(0, 0, 100, 50))
 
 // build NSAttributedString.
 let greed = "Hi, ".stylize().color(0x2200ee).size(12).font(.HelveticaNeue).attr
 
 // build NSAttributedString with ranges.
 let msg = "something happened ".stylize()
                .range(0..<9)        .color(0x009911).size(12).font(.HelveticaNeue)
                .range(10..<UInt.max).color(0xaa22cc).size(14).font(.HelveticaNeue_Bold).attr
 
 // build NSAttributedString objects and join them.
 let name = "to ".stylize().color(0x23abfc).size(12).font(.HelveticaNeue).attr +
            "you".stylize().color(0x123456).size(14).font(.HelveticaNeue_Italic).underline(.StyleDouble).attr
 
 label.attributedText = greed + msg + name
 ```
 
 
 This sample code generates the following styled label.
 
 <img width="261" src="https://cloud.githubusercontent.com/assets/18266814/14254571/49882d08-facb-11e5-9e3d-c37cbef6a003.png">

 */
open class StringStylizer<T: StringStylizerStatus>: ExpressibleByStringLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    fileprivate var _attrString: NSAttributedString
    fileprivate var _attributes = [NSAttributedStringKey: Any]()
    fileprivate var _range: CountableRange<UInt>
    
    // MARK:- Initializer
    
    init(string: String, range: CountableRange<UInt>? = nil, attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()) {
        let range = range ?? 0..<UInt(string.characters.count)
        
        _attrString = NSAttributedString(string: string)
        _attributes = attributes
        _range = range
    }
    
    init(attributedString: NSAttributedString, range: CountableRange<UInt>, attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()) {
        _attrString = attributedString
        _attributes = attributes
        _range = range
    }
    
    public required init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        _attrString = NSMutableAttributedString(string: value)
        _range = 0..<UInt(_attrString.string.characters.count)
    }
    
    public required init(stringLiteral value: StringLiteralType) {
        _attrString = NSMutableAttributedString(string: value)
        _range = 0..<UInt(_attrString.string.characters.count)
    }
    
    public required init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        _attrString = NSMutableAttributedString(string: value)
        _range = 0..<UInt(_attrString.string.characters.count)
    }
    
    // MARK:- Attributes
    // https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/index.html#//apple_ref/doc/c_ref/NSLinkAttributeName
    
    /**
    The value of NSForegroundColorAttributeName
    
    ### example
     
    ```
    
     
     "StringStylizer".stylize().color(.redColor()).attr
    `
     ``
    <img width="143" src="https://cloud.githubusercontent.com/assets/18320004/14388487/52403352-fde9-11e5-86fe-f94224dcc747.png">
     
    - parameter rgb:UInt
    - parameter alpha:Double (default: 1.0)
    - returns: StringStylizer<Styling>
    */
    open func color(_ rgb: UInt, alpha: Double = 1.0) -> StringStylizer<Styling> {
        _attributes[.foregroundColor] = self.rgb(rgb, alpha: alpha)
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSForegroundColorAttributeName
     
     
     ### example
     ```
     
     
     "StringStylizer".stylize().color(0xff0000).attr
     
     ```
     <img width="143" src="https://cloud.githubusercontent.com/assets/18320004/14388487/52403352-fde9-11e5-86fe-f94224dcc747.png">
     
     - parameter color:UIColor
     - returns: StringStylizer<Styling>
     */
    open func color(_ color: UIColor) -> StringStylizer<Styling> {
        _attributes[.foregroundColor] = color
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSFontAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().font(UIFont(name: "Copperplate-Light", size: 17)!).attr
     
     ```
     <img width="163" src="https://cloud.githubusercontent.com/assets/18320004/14388742/6986057c-fdea-11e5-9814-5a610684de0b.png">
     
     - parameter font:UIFont
     - returns: StringStylizer<Styling>
     */
    open func font(_ font: UIFont) -> StringStylizer<Styling> {
        _attributes[.font] = font
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }

    /**
     The name value of NSFontAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().font("Copperplate-Light").attr
     
     ```
     <img width="147" src="https://cloud.githubusercontent.com/assets/18320004/14388776/a274bf68-fdea-11e5-9634-840d0b5fdacb.png">
     
     - parameter name:String
     - returns: StringStylizer<Styling>
     */
    open func font(_ name: String) -> StringStylizer<Styling> {
        let font: UIFont
        if let currentFont = _attributes[.font] as? UIFont {
            font = UIFont(name: name, size: currentFont.pointSize) ?? UIFont()
        } else {
            font = UIFont(name: name, size: UIFont.systemFontSize) ?? UIFont()
        }
        
        _attributes[.font] = font
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The name value of NSFontAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().font(.Copperplate_Light).attr
     
     ```
     <img width="147" src="https://cloud.githubusercontent.com/assets/18320004/14388776/a274bf68-fdea-11e5-9634-840d0b5fdacb.png">
     
     - parameter name:StringStylizerFontName
     - returns: StringStylizer<Styling>
     */
    open func font(_ name: StringStylizerFontName) -> StringStylizer<Styling> {
        let font: UIFont
        if let currentFont = _attributes[.font] as? UIFont {
            font = UIFont(name: name.rawValue, size: currentFont.pointSize) ?? UIFont()
        } else {
            font = UIFont(name: name.rawValue, size: UIFont.systemFontSize) ?? UIFont()
        }
        
        _attributes[.font] = font
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The size value of NSFontAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().font(.Copperplate_Light).attr
     
     ```
     <img width="153" src="https://cloud.githubusercontent.com/assets/18320004/14388859/16328002-fdeb-11e5-99d7-2687525b5e3d.png">
     
     - parameter size:Double
     - returns: StringStylizer<Styling>
     */
    open func size(_ size: Double) -> StringStylizer<Styling> {
        let font: UIFont
        if let currentFont = _attributes[.font] as? UIFont {
            font = UIFont(name: currentFont.fontName, size: CGFloat(size)) ?? UIFont()
        } else {
            font = UIFont.systemFont(ofSize: CGFloat(size))
        }
        
        _attributes[.font] = font
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSBackgroundColorAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().background(0xff0000, alpha: 0.5).attr
     
     ```
     <img width="153" src="https://cloud.githubusercontent.com/assets/18320004/14388921/4a685702-fdeb-11e5-8005-efe8024beeb9.png">
     
     - parameter rgb:UInt
     - parameter alpha:Double (default:1.0)
     - returns: StringStylizer<Styling>
     */
    open func background(_ rgb: UInt, alpha: Double = 1.0) -> StringStylizer<Styling> {
        _attributes[.backgroundColor] = self.rgb(rgb, alpha: alpha)
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSKernAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().karn(5).attr
     
     ```
     <img width="210" src="https://cloud.githubusercontent.com/assets/18320004/14388994/94d50894-fdeb-11e5-9e78-7c31480bb00c.png">
     
     - parameter value:Double
     - returns: StringStylizer<Styling>
     */
    open func karn(_ value: Double) -> StringStylizer<Styling> {
        _attributes[.kern] = value as Any
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The values of NSUnderlineStyleAttributeName and NSUnderlineColorAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().underline(.StyleSingle, rgb: 0xff0000, alpha: 0.5).attr
     
     ```
     <img width="135" src="https://cloud.githubusercontent.com/assets/18320004/14389065/db66f77c-fdeb-11e5-8182-de300c85dc0e.png">
     
     - parameter style:NSUnderlineStyle...
     - parameter rgb:UInt? (default:nil)
     - parameter alpha:Double (default:1.0)
     - returns: StringStylizer<Styling>
     */
    open func underline(_ style: NSUnderlineStyle..., rgb: UInt? = nil, alpha: Double = 1) -> StringStylizer<Styling> {
        let _style: [NSUnderlineStyle] = style.isEmpty ? [.styleSingle] : style
        
        let value = _style.reduce(0) { (sum, elem) -> Int in
            return sum | elem.rawValue
        }
        _attributes[.underlineStyle] = value as Any
        _attributes[.underlineColor] = rgb.flatMap { self.rgb($0, alpha: alpha) }
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The values of NSStrokeWidthAttributeName and NSStrokeColorAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().stroke(rgb: 0xff0000, alpha: 1, width: 2).attr
     
     ```
     <img width="135" src="https://cloud.githubusercontent.com/assets/18320004/14389200/7fca9c74-fdec-11e5-996b-3ead1ac564cc.png">
     
     - parameter rgb:UInt? (default:nil)
     - parameter alpha:Double (default:1.0)
     - returns: StringStylizer<Styling>
     */
    open func stroke(rgb: UInt, alpha: Double = 1.0,  width: Double = 1) -> StringStylizer<Styling>  {
        _attributes[.strokeWidth] = width as Any
        _attributes[.strokeColor] = self.rgb(rgb, alpha: alpha)
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The values of NSStrokeWidthAttributeName and NSStrokeColorAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().stroke(color: .redColor(), alpha: 1, width: 2).attr
     
     ```
     <img width="135" src="https://cloud.githubusercontent.com/assets/18320004/14389200/7fca9c74-fdec-11e5-996b-3ead1ac564cc.png">
     
     - parameter color:UIColor
     - parameter alpha:Double (default:1.0)
     - parameter width:Double (default:1.0)
     - returns: StringStylizer<Styling>
     */
    open func stroke(color: UIColor, alpha: Double = 1.0,  width: Double = 1) -> StringStylizer<Styling>  {
        _attributes[.strokeWidth] = width as Any
        _attributes[.strokeColor] = color
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The values of NSStrikethroughStyleAttributeName and NSStrikethroughColorAttributeName
     
     ### example
     ```
     
     
     "StringStylizer".stylize().strokeThrogh(.StyleDouble, rgb: 0xff0000, alpha: 1).attr
     
     ```
     <img width="139" src="https://cloud.githubusercontent.com/assets/18320004/14389273/ddc222f2-fdec-11e5-9a80-0181383ef553.png">
     
     - parameter style:NSUnderlineStyle...
     - parameter rgb:UInt? (default:nil)
     - parameter alpha:Double (default:1.0)
     - returns: StringStylizer<Styling>
     */
    open func strokeThrogh(_ style: NSUnderlineStyle..., rgb: UInt? = nil, alpha: Double = 1) -> StringStylizer<Styling>  {
        let _style: [NSUnderlineStyle] = style.isEmpty ? [.styleSingle] : style
        
        let value = _style.reduce(0) { (sum, elem) -> Int in
            return sum | elem.rawValue
        }
        
        _attributes[.strikethroughStyle] = value as Any
        _attributes[.strikethroughColor] = rgb.flatMap { self.rgb($0, alpha: alpha) }
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSShadowAttributeName
     
     ### example
     ```
     let shadow = NSShadow()
     shadow.shadowOffset = CGSizeMake(1, 1)
     shadow.shadowColor = .redColor()
     shadow.shadowBlurRadius = 2
     "StringStylizer".stylize().shadow(shadow).attr
     ```
     <img width="138" alt="2016-04-10 18 35 27" src="https://cloud.githubusercontent.com/assets/18320004/14409343/ef91361c-ff4a-11e5-9c79-23e42a07ce81.png">
     
     - parameter value:NSShadow
     - returns: StringStylizer<Styling>
     */
    open func shadow(_ value: NSShadow) -> StringStylizer<Styling> {
        _attributes[.shadow] = value
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSShadowAttributeName. 
     
     Arguments are offset, rgb, alpha, blurRadius to make NSShadow
     
     ### example
     ```
     
     
     "StringStylizer".stylize().shadow(offset: (1, 1), color: .redColor(), blurRadius: 2).attr
     
     ```
     <img width="138" alt="2016-04-10 18 35 27" src="https://cloud.githubusercontent.com/assets/18320004/14409343/ef91361c-ff4a-11e5-9c79-23e42a07ce81.png">
     
     - parameter offset:(width: Double, height: Double)? offset (default is nil)
     - parameter rgb:UInt? Color with rgb (default is nil)
     - parameter alpha:Double Alpha (default is 1)
     - parameter blurRadius:Double BlurRadius (default is 0.3)

     - returns: StringStylizer<Styling>
     */
    open func shadow(offset: (width: Double, height: Double)? = nil, color: UIColor? = nil, blurRadius: Double? = nil) -> StringStylizer<Styling> {
        let shadow = NSShadow()

        if let offset = offset {
            shadow.shadowOffset = CGSize(width: CGFloat(offset.width), height: CGFloat(offset.height))
        }
        
        if let color = color {
            shadow.shadowColor = color
        }
        
        if let blurRadius = blurRadius {
            shadow.shadowBlurRadius = CGFloat(blurRadius)
        }
        
        _attributes[.shadow] = shadow
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSLigatureAttributeName
     
     - parameter value:Int
     - returns: StringStylizer<Styling>
     */
    open func ligeture(_ value: Int) -> StringStylizer<Styling> {
        _attributes[.ligature] = value as Any
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSLinkAttributeName
     
     - parameter url:NSURL
     - returns: StringStylizer<Styling>
     */
    open func link(_ url: URL) -> StringStylizer<Styling> {
        _attributes[.link] = url as Any
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     The value of NSBaselineOffsetAttributeName
     
     - parameter value:Double
     - returns: StringStylizer<Styling>
     */
    open func baselineOffset(_ value: Double) -> StringStylizer<Styling> {
        _attributes[.baselineOffset] = value as Any
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    /**
     count String length
     
     - returns: Int
     */
    open var count: Int {
        return _attrString.length
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

public extension StringStylizer {
    public func paragraph(_ style: NSParagraphStyle) -> StringStylizer<Styling> {
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }

    public func paragraphAlignment(_ alignment: NSTextAlignment) -> StringStylizer<Styling> {
        let style: NSMutableParagraphStyle
        if let currentStyle = _attributes[.paragraphStyle] as? NSMutableParagraphStyle {
            currentStyle.alignment = alignment
            style = currentStyle
        } else {
            style = NSMutableParagraphStyle()
            style.alignment = alignment
        }
        
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }

    public func paragraphIndent(firstLineHead: CGFloat? = nil, tail: CGFloat? = nil, otherHead: CGFloat? = nil) -> StringStylizer<Styling> {
        let style = getParagraphStyle()
        
        if let firstLineHead = firstLineHead {
            style.firstLineHeadIndent = firstLineHead
        }
        
        if let otherHead = otherHead {
           style.headIndent = otherHead
        }
        
        if let tail = tail {
            style.tailIndent = tail
        }
        
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    public func paragraphLineBreak(_ lineBreakMode: NSLineBreakMode) -> StringStylizer<Styling> {
        let style = getParagraphStyle()
        style.lineBreakMode = lineBreakMode
        
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    public func paragraphLineHeight(maximum: CGFloat? = nil, minimum: CGFloat? = nil, multiple: CGFloat? = nil) -> StringStylizer<Styling> {
        let style = getParagraphStyle()
        
        if let maximum = maximum {
            style.maximumLineHeight = maximum
        }

        if let minimum = minimum {
            style.minimumLineHeight = minimum
        }
        
        if let multiple = multiple {
            style.lineHeightMultiple = multiple
        }
        
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    public func paragraphLineSpacing(after: CGFloat? = nil, before: CGFloat? = nil) -> StringStylizer<Styling> {
        let style = getParagraphStyle()
        
        if let after = after {
            style.lineSpacing = after
        }
        
        if let before = before {
            style.paragraphSpacingBefore = before
        }
        
        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    public func paragraphBaseWritingDirection(_ baseWritingDirection: NSWritingDirection) -> StringStylizer<Styling> {
        let style: NSMutableParagraphStyle
        if let currentStyle = _attributes[.paragraphStyle] as? NSMutableParagraphStyle {
            style = currentStyle
        } else {
            style = NSMutableParagraphStyle()
        }
        
        style.baseWritingDirection = baseWritingDirection

        _attributes[.paragraphStyle] = style
        let stylizer = StringStylizer<Styling>(attributedString: _attrString, range: _range, attributes: _attributes)
        return stylizer
    }
    
    fileprivate func getParagraphStyle() -> NSMutableParagraphStyle {
        if let currentStyle = _attributes[.paragraphStyle] as? NSMutableParagraphStyle {
            return currentStyle
        } else {
            return NSMutableParagraphStyle()
        }
    }
}

public extension StringStylizer where  T: Styling {
    /// generates NSAttributedString
    public var attr: NSAttributedString {
        let range: Range = Int(_range.startIndex)..<Int(_range.endIndex)
        let attrString = NSMutableAttributedString(attributedString: _attrString)
        attrString.setAttributes(_attributes, range: NSRange(range))
        return attrString
    }
    
    /**
     set range to assign attributes
     
     - parameter range:Range (default: nil)
     - returns: StringStylizer<NarrowDown>
     */
    public func range(_ range: CountableRange<UInt>? = nil) -> StringStylizer<NarrowDown> {
        let attrString = NSMutableAttributedString(attributedString: _attrString)
        attrString.setAttributes(_attributes, range: NSRange(Int(_range.startIndex)..<Int(_range.endIndex)))
        
        let range = range ?? 0..<UInt(attrString.length)
        let endIndex = min(range.endIndex, UInt(_attrString.length))
        let validRange = range.startIndex..<endIndex
        return StringStylizer<NarrowDown>(attributedString: attrString, range: validRange)
    }

    /**
     set search to assign attributes

     - parameter rangeString: String
     - returns: StringStylizer<NarrowDown>
    */
    public func search(_ rangeString: String) -> StringStylizer<NarrowDown> {
        let nsrange = NSString(string: _attrString.string).range(of: rangeString)
        let range = CountableRange<UInt>(uncheckedBounds: (lower: UInt(nsrange.location), upper: UInt(nsrange.location + nsrange.length)))
        return StringStylizer<NarrowDown>(attributedString: _attrString, range: range)
    }

}
