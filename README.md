![ackee|ACKategories](https://github.com/AckeeCZ/ACKategories/blob/master/Resources/cover-image.png)

[![CI Status](http://img.shields.io/travis/AckeeCZ/ACKategories.svg?style=flat)](https://travis-ci.org/AckeeCZ/ACKategories)
[![Version](https://img.shields.io/cocoapods/v/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)
[![License](https://img.shields.io/cocoapods/l/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)
[![Platform](https://img.shields.io/cocoapods/p/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)

A bunch of tools, cocoa subclasses and extensions we created and use at Ackee.

## Installation

ACKategories is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "ACKategories"
```

## List of features
This is only fast description of features, see source code for documentation commentsand details.

### Button
Extension for Button that fixes `intrinsicContentSize()` and adds `titleEdgeInsets` to it.

### Color
- Initialize colors with hex codes
- Create random color
- Create lighter/darker colors from color
- Recognize light/dark background colors to decide what text color you should use.
- Create solid color image from color.

### Control
Add action blocks to Controls.
```swift
let button = UIButton()
button.on(.TouchUpInside) { sender in
	...
}
```

### String
- trim strings easily
- get first letter of string
- simplify localization
- get length of string easily

### TableHeaderFooterView
Use this view as TableHeaderView or TableFooterView when your table/footer has dynamic content size.

## Author

[Ackee](https://ackee.cz) team

## License

ACKategories is available under the MIT license. See the LICENSE file for more info.
