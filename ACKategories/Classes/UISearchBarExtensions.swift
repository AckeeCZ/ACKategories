import UIKit

public extension UISearchBar {
    public var textField: UITextField! { return value(forKey: "searchField") as! UITextField }
}
