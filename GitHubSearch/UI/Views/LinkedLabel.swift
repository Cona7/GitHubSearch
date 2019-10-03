import TTTAttributedLabel
import UIKit

class LinkedLabel: TTTAttributedLabel {
    func setupLabel(url: URL) {
        let stringUrl = url.absoluteString

        numberOfLines = 0

        enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        delegate = self

        linkAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        activeLinkAttributes = [NSAttributedString.Key.foregroundColor: UIColor.dark, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]

        let attributedString = NSMutableAttributedString(
            string: "Link: \(stringUrl)",
            attributes: [
                .foregroundColor: UIColor.darkText,
                .font: UIFont.regularFont(ofSize: 14)
            ]
        )

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 20

        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )

        attributedText = attributedString

        addLink(to: url, with: NSRange(location: 6, length: stringUrl.count))
    }
}

extension LinkedLabel: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
