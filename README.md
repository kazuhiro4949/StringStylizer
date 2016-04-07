# StringStylizer
Type strict builder class for [NSAttributedString](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/). 

## What's this?
StringStylizer makes NSAttributedString more intuitive with Method chain and Operator.
Building NSAttributedString is so difficult that it requires us to remember attribute names and types. If you do that with StringStylizer, There is no need to remember them :smiley:

NSAttributedString has the following format.
```swift
let attr: [String: AnyObject] = [
    NSForegroundColorAttributeName: UIColor.whiteColor(),
    NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14)
]
let str = NSAttributedString(string: "some text", attributes: attr)
```

StringStylizer enable developers to read and write their code in a linear manner.
If you wanna convert String to NSAttributedString which has some colors, sizes and fonts, you can write it as follows.
```swift
let str = "some text".stylize().color(.whiteColor()).size(14).font(.HelveticaNeue).attr
```

## Feature
- [x] Type strict format
- [x] Assigning ranges and attributes in a linear manner
- [x] More readable than NSAttributedString

## Requirements
- iOS 8.0+
- Swift 2.0+

## Installation
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
github "kazuhiro49/StringStylizer"
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

Of course, you can wrap up the method chains of StringStylizer. 
```swift
extension StringStylizer {
  func strong() -> NSAttributedString {
    return self.stylize()
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
#### 5. Join other NSAttributedString objects.
```swift
let one     = "yay!".stylize().range(0..<UInt.max).size(14).attr
let another = " yay!".stylize().color(0xffffff).attr
let fifthStep = one + another // => NSAttributedString
```

That's it!

## Architecture
StringStylizer is based on **"Builder Pattern"** (Effective Java version). In addition, it has states managed by **"Phantom Type"**.

<img width="800" src="https://cloud.githubusercontent.com/assets/18266814/14271674/4d5bb9de-fb36-11e5-819c-cb2061d49be4.png">

Because of them, we are able to
- write our code in a liner manner
- call proper methods depending on the situation.

## License

StringStylizer is released under the MIT license. See LICENSE.txt for details.
