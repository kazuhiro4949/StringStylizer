# StringStylizer

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Cocoapods compatible](https://cocoapod-badges.herokuapp.com/v/StringStylizer/1.1.1/badge.png)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
![Swift 3.2](https://img.shields.io/badge/Swift-3.2-orange.svg)

Type strict builder class for [NSAttributedString](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/). 


## What's this?
StringStylizer makes NSAttributedString more intuitive with Method chain and Operator.
Building NSAttributedString is so difficult because it requires us to remember attribute names and types. If you do that with StringStylizer, There is no need to remember them :smiley:

NSAttributedString has the following format.
```swift
let attr: [String: AnyObject] = [
    NSForegroundColorAttributeName: UIColor.whiteColor(),
    NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14)
]
let str = NSAttributedString(string: "some text", attributes: attr)
```

StringStylizer enable developers to read and write their code in a linear manner.
If you wanna convert String to NSAttributedString which has some colors, sizes and fonts, you can write that as follows.
```swift
let str = "some text".stylize().color(.whiteColor()).size(14).font(.HelveticaNeue).attr
```

## Feature
- [x] Type strict format
- [x] Assigning ranges and attributes in a linear manner
- [x] More readable than NSAttributedString

## Requirements
- iOS 8.0+
- Swift 3.0 or Swift 2.3 (swift2.3 branch)

## Installation
### Carthage

+ Install Carthage from Homebrew
```
> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
> brew update
> brew install carthage
```
+ Move your project dir and create Cartfile
```
> touch Cartfile
```
+ add the following line to Cartfile
```
github "kazuhiro4949/StringStylizer"
```
+ Create framework
```
> carthage update --platform iOS
```

+ In Xcode, move to "Genera > Build Phase > Linked Frameworks and Library"
+ Add the framework to your project
+ Add a new run script and put the following code
```
/usr/local/bin/carthage copy-frameworks
```
+ Click "+" at Input file and Add the framework path
```
$(SRCROOT)/Carthage/Build/iOS/StringStylizer.framework
```
+ Write Import statement on your source file
```
Import StringStylizer
```

### CocoaPods
+ Install CocoaPods
```
> gem install cocoapods
> pod setup
```
+ Create Podfile
```
> pod init
```
+ Edit Podfile
```ruby
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'  # add
use_framework!  # add

target 'MyAppName' do
  pod 'StringStylizer' # add
end

target 'MyAppTests' do

end

target 'MyAppUITests'
```

+ Install

```
> pod install
```
open .xcworkspace

## Example
 
 ```swift
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

This sample generates a styled label.
 
<img width="350" src="https://cloud.githubusercontent.com/assets/18266814/14254571/49882d08-facb-11e5-9e3d-c37cbef6a003.png">

Of course, you can wrap up the method chains. 
```swift
extension StringStylizer {
  func strong() -> NSAttributedString {
    return self
            .color(0x123456)
            .size(14)
            .font(.HelveticaNeue_Italic)
            .underline(.StyleDouble)
            .attr
  }
}

label.attributedText = "you".stylize().strong()
```

## Usage
#### 1. Convert String to StringStylizer object
```swift
let firstStep = "yay!".stylize() // => StringStylizer<Styling>
```
#### 2. Call methods to select range. Then, StringStylizer change into "NarrowDown" state
```swift
let secondStep = "yay!".stylize().range(0..<UInt.max) // => StringStylizer<NarrowDown>
```
#### 3. Call methods to set attributes. Then, StringStylizer change into "Styling" state
```swift
let thirdStep = "yay!".stylize().range(0..<UInt.max).size(14) // => StringStylizer<Styling>
```
#### 4. Convert to NSAttributedString object.
```swift
let fourthStep = "yay!".stylize().range(0..<UInt.max).size(14).attr // => NSAttributedString
```
#### 5. Join another NSAttributedString object.
```swift
let one     = "yay!".stylize().range(0..<UInt.max).size(14).attr
let another = " yay!".stylize().color(0xffffff).attr
let fifthStep = one + another // => NSAttributedString
```

That's it!

## Architecture
StringStylizer is based on **"Builder Pattern"** (Effective Java version). In addition, it has states managed by **"Phantom Type"**.

<img width="800" src="https://cloud.githubusercontent.com/assets/18320004/18075348/f038fec8-6eae-11e6-8e9c-98c0fa39bcde.png">

Because of them, we are able to
- write our code in a liner manner
- call proper methods depending on the situation.

## License

Copyright (c) 2016 Kazuhiro Hayashi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
