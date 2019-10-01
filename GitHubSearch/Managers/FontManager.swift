import UIKit

// Text styles

extension UIFont {
    class func regularFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .regular)
    }

    class func boldFont(size: CGFloat) -> UIFont {
           return UIFont.boldSystemFont(ofSize: size)
       }
}
