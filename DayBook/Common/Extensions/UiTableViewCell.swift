import UIKit

extension UITableViewCell {
    class var reuseIdentifier: String { return String(describing: self) }
    
    class var nibName: String { return String(describing: self) }

    class var nib: UINib { return UINib(nibName: nibName, bundle: nil) }
}
