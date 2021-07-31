# SwiftUI.AnimatedImage

SwiftUI animated image view that works on iOS and layout just as SwiftUI.Image


https://user-images.githubusercontent.com/758033/127722908-4d760937-2420-4d78-a9d7-38c5bc6dffe0.mov

## Installation

### Swift Package Manager

```
dependencies: [
    .package(url: "https://github.com/krzyzanowskim/SwiftUI.AnimatedImage", from: "1.0")
],
```

## Usage

```swift
import AnimatedImage

struct MyView: View {

    var body: some View {
        AnimatedImage(data: imageData)
            .scaledToFit()

    }
    
}

```
