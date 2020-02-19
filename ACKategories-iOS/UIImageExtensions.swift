import UIKit

extension UIImage {

    /// Fix image orientation when sending e.g. to API
    ///
    /// Taken from http://stackoverflow.com/questions/10850184/ios-image-get-rotated-90-degree-after-saved-as-png-representation-data
    public func fixedOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()

        return normalizedImage
    }

    /// Resize image to `maxDimension`
    ///
    /// If greater dimension is larger than `maxDimension` image will be resized to match it respection its aspect ratio.
    public func resized(maxDimension: CGFloat) -> UIImage? {
        let isLandscape = size.width > size.height

        let newSize: CGSize
        if isLandscape {
            newSize = CGSize(width: maxDimension, height: (size.height / size.width) * maxDimension)
        } else {
            newSize = CGSize(width: (size.width / size.height) * maxDimension, height: maxDimension)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}
