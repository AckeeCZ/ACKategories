# Changelog

- please enter new entries in format 

```
- <description> (#<PR_number>, kudos to @<author>)
```

## Next
- Fix swiftlint violations ([#69](https://github.com/AckeeCZ/ACKategories/pull/69), kudos to @fortmarek)
- Update tapestry structure ([#68](https://github.com/AckeeCZ/ACKategories/pull/68), kudos to @fortmarek)
- Add [swift-doc](https://github.com/SwiftDocOrg/swift-doc) action, checks actions ([#67](https://github.com/AckeeCZ/ACKategories/pull/67), kudos to @fortmarek)
- add `UIDevice.current.modelName` extension to receive model name of current device (#66, kudos to @olejnjak)
- separate frameworks for Swift and iOS (#64, kudos to @olejnjak)
- Fix wrong transparency in `UIColor.image()` (#65, kudos to @janmisar)
- add `clearLaunchScreenCache()` to completely clear launch screen cache (#63, kudos to @igorrosocha)
- use native `UISearchBar.searchTextField` on iOS 13+ (#61, kudos to @olejnjak)

## 6.3
- add support for generic dequeueing for MKAnnotationViews `dequeueAnnotationView(for annotation: MKAnnotation)` (#60, kudos to @svastven)
- add support for Dark Mode when creating colored images from `UIColor` (#59, kudos to @svastven)
- add `tapestry` for automating future releases (#56, kudos to @fortmarek)
- update [FlowCoordinator](ACKategories/Base/FlowCoordinator.swift) to count with iOS 13 modal presentations (#55, kudos to @olejnjak)

## 6.2
- add `forceIntrinsic()` to `UIView` to set its `contentHuggingPriority` and `contentCompressionResistance` to `UILayoutPriority.required` (#48, kudos to @olejnjak)
- add `hexString` closure into `UIColorExtension` that will return hex string from `UIColor` (#49, kudos to @majkcajk)
- add SwiftPM manifest (#52, kudos to @olejnjak)
- add `type` parameter to `dequeueCell(...)` methods so using it is more convenient (#53, kudos to @olejnjak)

  From now you can also use
  ```swift
  tableView.dequeueCell(for: indexPath, type: YourCell.self)
  ```

## 6.1
- added deep link generic for `Base.FlowCoordinator` (#47, kudos to @fortmarek)
- Swift 5 & Xcode 10.2 migration (#45, kudos to @janmisar)
- base classes for VCs, VMs, FCs (#45, kudos to @janmisar)

## 6.0.3
- fix init emoji in `FlowCoordinator` (#42, kudos to @Dominoo)

## 6.0.2
- move from NSLog to unified logging (#39, kudos to @fortmarek)
- allow additional logic for isEmpty for collections (#40, kudos to @fortmarek) 
- add LICENSE file to Cocoapods source files

