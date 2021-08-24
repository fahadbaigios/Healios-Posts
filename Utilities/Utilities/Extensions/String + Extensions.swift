//
//  String + Extensions.swift
//  Common
//
//  Created by Taimour Tanveer on 03/01/2019.
//  Copyright © 2019 Techtix co. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    /// Returns localized version of the original String. Original String is echoed if no suitable translation string is found is found.
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
    
    var documentPath:String{
      return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    /// Check if string contains one or more emojis.
    ///
    ///     "You're funny 😂".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// Check if string is a valid URL.
    ///
    ///     "https://google.com".isValidUrl -> true
    ///
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// CamelCase of string.
    ///
    ///     "sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// Check if string is a valid Swift number.
    ///
    /// Note:
    /// In North America, "." is the decimal separator,
    /// while in many parts of Europe "," is used,
    /// Scans string according to `NSLocale.current`
    ///
    ///     "123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///     "abc".isNumeric -> false
    ///
    var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    /// Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// Check if string contains one or more letters.
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    /// Check if string contains one or more numbers.
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
	/*
    /// Check if string contains only letters.
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    /// Check if string contains at least one letter and one number.
    ///
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    /// SwifterSwift: Check if string is valid email format.
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".isValidEmail -> true
    ///
    public var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", RegEx.email).evaluate(with: self)
        //return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }*/


	/// Check if string is valid according to regular expression
	///
	/// - Parameter exp: regular expression
	/// - Returns: validation status of text
    func isValid(forExp exp: String) -> Bool {
		guard let test = NSPredicate(format:"SELF MATCHES %@", exp) as NSPredicate? else { return false }
		return test.evaluate(with: self)
	}



	/// This component is used to create a NSAttributedString with text having different font and color
	/// See attributedString(components: AttributedStringComponent...)
    struct AttributedStringComponent{
		let title: String
		let font: UIFont
		let color: UIColor
		let separator: String


		/// Creates new instance of AttributedStringComponent
		///
		/// - Parameters:
		///   - title: text of component
		///   - font: font of component
		///   - color: color of text
		///   - separator: text between this and next component
		public init (title: String, font: UIFont, color: UIColor, separator: String = " ") {
			self.title = title
			self.font = font
			self.color = color
			self.separator = separator
		}
	}


	/// Creates an NSAttributedString with different fonts and colors
	///
	/// - Parameter components: array of component which are merged into single NSAttributedString
	/// - Returns: merged NSAttributedString 
    static func attributedString(components: AttributedStringComponent...) -> NSAttributedString {

		let mergedAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: ""))
		for component in components {
			let componentAttributedString = attributedString(forSingleComponent: component)
			mergedAttributedString.append(componentAttributedString)
		}

		return mergedAttributedString
	}

	private static func attributedString(forSingleComponent component: AttributedStringComponent) -> NSAttributedString{
		let attributes = [NSAttributedString.Key.font: component.font,
						  NSAttributedString.Key.foregroundColor: component.color]
		return NSAttributedString(string: component.title+component.separator, attributes: attributes)
	}
    
    
}
