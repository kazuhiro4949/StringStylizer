//
//  String+StringStylizer.swift
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

import Foundation

public extension String {
    /**
     Instantiate StringStylizer<Styling> from caller string.
    
     - returns: StringStylizer<Styling> "StringStylizer" object which is "Styling" state
     */
    func stylize() -> StringStylizer<Styling> {
        let attributer = StringStylizer<Styling>(string: self)
        return attributer
    }
    
    /**
     Instantiate StringStylizer<Styling> with range value from caller string.
     
     - parameter range:Range<UInt> range to apply attributes
     - returns: StringStylizer<Styling> "StringStylizer" object which is "Styling" state
     */
    func stylize(range: CountableRange<UInt>) -> StringStylizer<NarrowDown> {
        let attributer = StringStylizer<Styling>(string: self)
        return attributer.range(range)
    }
}


public extension Optional where Wrapped == String {
    
    func stylize() -> StringStylizer<Styling> {
        return (self ?? "").stylize()
    }
    
}
