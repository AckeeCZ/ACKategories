import UIKit

public extension UISearchBar {
    /// Shorthand for contained textField
    var textField: UITextField! { return value(forKey: "searchField") as? UITextField }
}
