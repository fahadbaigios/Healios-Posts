import Foundation
/*
//"J3-123A" i.e
struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format")
        }
        return value
    }
}


class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}*/


/*
/// Validates Email
class EmailValidator: BaseValidator {
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.email.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Email is not valid"))
        }
    }
}


// Validates Password
class PinValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.pin.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Pin is not valid"))
        }
    }
}

// Validates IBAN
class IBANValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.iban.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "IBAN is not valid"))
        }
    }
}

// Validates Account Title
class AccountTitleValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.accountTitle.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Account Title"))
        }
    }
}

// DigitsValidator
class DigitsValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }
        else if text.isValid(forExp: ValidatorType.digitsOnly.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
    }
}


// DigitsValidator
class DigitsOnlyExceptZeroValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        } else if text == "0" {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        } else if removedZeros(string: text) == "" {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
        else if text.isValid(forExp: ValidatorType.digitsOnly.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
    }
    
    private func removedZeros(string: String) -> String {
        return string.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
    }
}

// DigitsValidator
class DigitsOnlyExceptZeroWith40KLimitValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        let valueInt = Int(text) ?? 0
        if text.isEmpty {
            return .empty
        } else if text == "0" {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        } else if valueInt > 40000 {
            return .invalid(invalidStateMessage(defaultMessage: "Exceeding 40000"))
        }
            else if removedZeros(string: text) == "" {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
        else if text.isValid(forExp: ValidatorType.digitsOnly.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
    }
    
    private func removedZeros(string: String) -> String {
        return string.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
    }
}




//MARK: Emirates ID Validator
class EmiratesIDValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.emiratesID.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Data"))
        }
    }
}

// Validates Swift Code
class SwiftCodeValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.swiftCode.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Swift Code"))
        }
    }
}

// Validates Swift Code
class AccountNumberValidator: BaseValidator {
    
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.accountNumber.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Invalid Account Number"))
        }
    }
}

/// Validates Password
class PasswordValidator: BaseValidator {

    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.password.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Password is not valid"))
        }
    }
}

/// Validates Name
class NotEmptyValidator: BaseValidator {
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.notEmpty.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Field is not valid"))
        }
    }
}

/// Validates Phone
class PhoneValidator: BaseValidator {
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.phoneNo.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Phone no is not valid"))
        }
    }
}


/// Validates Phone
class NameWithWhiteSpaceValidator: BaseValidator {
    override func validate(text: String) -> ValidationState {
        if text.isEmpty {
            return .empty
        }else if text.isValid(forExp: ValidatorType.nameWithWhiteSpaces.rawValue) {
            return .valid
        }else {
            return .invalid(invalidStateMessage(defaultMessage: "Name is not valid"))
        }
    }
}
*/
