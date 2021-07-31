import SwiftUI
import Combine

public struct AnimatedImage: View {
    @State private var frameIndex = 0

    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let frameCount: Int
    private let images: [UIImage]

    public init(data imageData: Data, loop: Bool = true) {
        let source = CGImageSourceCreateWithData(imageData as CFData, nil)!

        self.frameCount = CGImageSourceGetCount(source)

        self.images = (0..<frameCount).compactMap {
            CGImageSourceCreateImageAtIndex(source, $0, nil)
        }.map {
            UIImage(cgImage: $0)
        }

        let duration = (0..<frameCount).reduce(0) { total, idx in
            total + source.gifAnimationDelay(imageAtIndex: idx)
        }

        self.timer = Timer.publish(every: duration / Double(frameCount), on: .main, in: .common).autoconnect()
    }

    public init(animatedImage image: UIImage) {
        self.images = image.images ?? [image]
        self.frameCount = images.count
        self.timer = Timer.publish(every: image.duration / Double(frameCount), on: .main, in: .common).autoconnect()
    }

    public var body: some View {
        Image(uiImage: images[frameIndex])
            .resizable()
            .onReceive(timer) { _ in
                if frameIndex + 1 < frameCount {
                    frameIndex += 1
                } else {
                    frameIndex = 0
                }
            }
    }
}

private extension CGImageSource {
    func gifAnimationDelay(imageAtIndex imageIdx: Int) -> TimeInterval {
        guard let properties = CGImageSourceCopyPropertiesAtIndex(self, imageIdx, nil) as? [String:Any],
              let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
            return 0.1
        }

        if let unclampedDelayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? TimeInterval {
            return unclampedDelayTime.isZero ? 0.1 : unclampedDelayTime
        } else if let gifDelayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval {
            return gifDelayTime.isZero ? 0.1 : gifDelayTime
        }
        return 0.1
    }
}

