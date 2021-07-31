import SwiftUI

@main
struct AnimatedImageApp: App {
    var body: some Scene {
        WindowGroup {

            AnimatedImage(data: image)
                .scaledToFit()
            
        }
    }

    var image: Data {
        NSDataAsset(name: "sample")!.data
    }
}
