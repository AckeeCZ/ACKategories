#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIApplication {
    /// The system caches launch images and is really bad at clearing it, even after the app has been deleted and re-launched,
    /// which causes the launch screen not to display new/correct images.
    /// This method completely clears launch screen cache.
    ///
    /// You can put it in your app’s initialization code behind an argument flag that you enable during launch screen development,
    /// then leave it disabled when you’re not working on your launch screen.
    ///
    /// Source: https://rambo.codes/posts/2019-12-09-clearing-your-apps-launch-screen-cache-on-ios
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }
}
#endif
