//

import Foundation
import UIKit


//let UUID = UIDevice.current.identifierForVendor?.uuidString ?? ""
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func UTC_To_localDate(utcDateFormat:String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = utcDateFormat
        dateFormater.timeZone = TimeZone(abbreviation: "UTC")
        if let dt = dateFormater.date(from: self) {
            dateFormater.timeZone = TimeZone.current
            return dateFormater.string(from: dt)
        }
        else {
            return ""
        }
    }
    
    func formatedStringDate(formate:String)->String{
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let endDate = dateFormater.date(from: self) {
//            formatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormater.timeZone = TimeZone.current
            dateFormater.dateFormat = formate
            return dateFormater.string(from: endDate)
        }
        else {
            return ""
        }
        
    }
    
    func isToday() -> Bool {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let endDate = dateFormater.date(from: self) else {
            return false
        }
        return Calendar.current.isDateInToday(endDate)
        
    }
    
    func isFuture() -> Bool {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let endDate = dateFormater.date(from: self) else{
            return false
        }
        // when date is in future returns true
        return endDate.timeIntervalSince(Date()).sign == .plus
        
    }
    
   
}

extension Date{
    func dateToString(formate:String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formate
        
        let date = dateFormater.string(from: self)
        return date
    
    }
}
extension UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }
}
@IBDesignable extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
    
    @IBInspectable var RightImage: UIImage {
        get{
            return UIImage()
        }
        set{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 9, width: 12, height: 8))
            imageView.image = newValue
            let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageContainerView.addSubview(imageView)
            rightView = imageContainerView
            rightViewMode = .always
        }
    }
    
    @IBInspectable var LeftImage: UIImage {
        get{
            return UIImage()
        }
        set{
            let imageView = UIImageView(frame: CGRect(x: 5, y: 10, width: 15, height: 15))
            imageView.image = newValue
            let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageContainerView.addSubview(imageView)
            leftView = imageContainerView
            leftViewMode = .always
        }
    }

}

@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UISwitch {
    @IBInspectable var OffTint: UIColor {
        set {
            self.tintColor = newValue
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
        get {
            return self.tintColor
        }
    }
}

extension NSAttributedString {
    
    @objc convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
        let options: [String : Any] = [
            convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.documentType): convertFromNSAttributedStringDocumentType(NSAttributedString.DocumentType.html),
            convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.characterEncoding): String.Encoding.utf8.rawValue
        ]
        
        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary(options), documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary(options), documentAttributes: nil)
            return
        }
        
        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(NSAttributedString.Key(rawValue: convertFromNSAttributedStringKey(NSAttributedString.Key.font)), in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitBold)!
                }
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitItalic)!
                }
                
                attr.addAttribute(NSAttributedString.Key.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }
        
        self.init(attributedString: attr)
    }
    
}

extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary([convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.documentType): convertFromNSAttributedStringDocumentType(NSAttributedString.DocumentType.html), convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.characterEncoding): String.Encoding.utf8.rawValue]), documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringDocumentReadingOptionKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.DocumentReadingOptionKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.DocumentReadingOptionKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentAttributeKey(_ input: NSAttributedString.DocumentAttributeKey) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentType(_ input: NSAttributedString.DocumentType) -> String {
    return input.rawValue
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// finding indexes in any array
extension Array where Element: Equatable {
    func findIndexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
