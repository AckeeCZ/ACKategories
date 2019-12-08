import UIKit

public extension UISearchBar {
    /// Shorthand for contained textField
    ///
    /// On iOS 13+ this just calls `searchTextField`, and if you're targeting iOS 13+,
    /// you should use that as you get `UISearchTextField` instead of just `UITextField`.
    var textField: UITextField! {
        if #available(iOS 13, *) {
            return searchTextField
        }
        return value(forKey: "searchField") as? UITextField
    }
}
