![ackee|ACKategories](https://github.com/AckeeCZ/ACKategories/blob/master/Resources/cover-image.png)

[![CI Status](http://img.shields.io/travis/AckeeCZ/ACKategories.svg?style=flat)](https://travis-ci.org/AckeeCZ/ACKategories)
[![Version](https://img.shields.io/cocoapods/v/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)
[![Platform](https://img.shields.io/cocoapods/p/ACKategories.svg?style=flat)](http://cocoapods.org/pods/ACKategories)

A bunch of tools, cocoa subclasses and extensions we created and use at Ackee.

## Installation

### CocoaPods

ACKategories is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "ACKategories"
```

### Carthage

You can also use [Carthage](https://github.com/Carthage/Carthage). Specify this repo in your Cartfile:

```
github "AckeeCZ/ACKategories"
```

ACKategories is meant to be used with **Swift 2.2** and **Xcode 7.3.1**.

### Swift 2.3
If you're interested in using ACKategories in your **Swift 2.3** projects you might want to see branch `swift2.3`.

## List of features
This is only fast description of features, see source code for documentation commentsand details.

### Button
Extension for Button that fixes `intrinsicContentSize` and adds `titleEdgeInsets` to it.

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
button.on(.touchUpInside) { sender in
	...
}
```
If running on iOS 9 or later you can use implicit parameter `UIControl.primaryActionTriggered`.

### String
- trim strings easily
- get first letter of string
- simplify localization
- get length of string easily

### TableHeaderFooterView
Use this view as TableHeaderView or TableFooterView when your table/footer has dynamic content size.

### UITableView and UICollectionView extensions
Since now you can use simple extension which autoregisters your `UITableView` and `UICollectionView` cells!
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell: YourCustomCell = tableView.dequeCellForIndexPath(indexPath) // generically dequed cell which was autoregistered, no need to register your cells in advance
  return cell
}
```
And it's the same story with `UICollectionView`.

## Forking this repository 
If you use our extensions within your team we would love to hear about it. Drop us a tweet at [@ackeecz][1] or leave a star here on Github. BTW we would also like to know what other extensions you use!

## Sharing is caring
This repo has been opensourced within our `#sharingiscaring` action when we have decided to opensource our internal projects.

## Author

[Ackee](https://ackee.cz) team

## License

ACKategories is available under the MIT license. See the LICENSE file for more info.

[1]:	https://twitter.com/AckeeCZ
