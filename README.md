# swift-magic
A Swift wrapper for libmagic

swift-magic is a Swift interface to the libmagic file type
identification library.  libmagic identifies file types by checking
their headers according to a predefined list of file types. This
functionality is exposed to the command line by the Unix command
`file`.

## Usage

```swift
import Magic

let description = try Magic.shared.file(path)
```

## Requirements
swift-magic is written in Swift 4.2. Compatible with iOS 8.0+

## Installation

### CocoaPods
swift-magic is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'swift-magic'
```

### Carthage
For [Carthage](https://github.com/Carthage/Carthage), add the following to your `Cartfile`:

```ogdl
github "kishikawakatsumi/swift-magic"
```

## Author
Kishikawa Katsumi, kishikawakatsumi@mac.com

## License
swift-magic is available under the BSD license. See the LICENSE file for more info.
