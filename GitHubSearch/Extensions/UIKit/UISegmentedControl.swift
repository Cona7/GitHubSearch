import UIKit

extension UISegmentedControl {
   func insertSegments(items: [String]) {
        for (index, title) in items.enumerated() {
            insertSegment(withTitle: title, at: index, animated: false)
        }
    }
}
