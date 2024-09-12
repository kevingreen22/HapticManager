[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

# HapticManager

A simple haptic engine manager.

If you like the project, please do not forget to `star ★` this repository and follow me on GitHub.


## 📦 Requirements

- iOS 14.0+
- Xcode 13.0+
- Swift 5.0


## Installation 

To install the component add it to your project using Swift Package Manager with url below.

```
https://github.com/kevingreen22/HapticManager
```

Import the package.

```swift
import HapticManager
```

## Example
Plays a standard haptic notification feedback.
   
```swift
if allowHaptics {
    HapticManager.instance.feedback(.warning)
}
```
OR as a SwiftUI view modifier that triggers with the passed in trigger argument and condition,

```swift
.haptic(impact: .light, intensity: 1, type: .warning, trigger: currentPage) { value in
    // conditional statement here...
    allowsHaptics ? true : false
}
```
