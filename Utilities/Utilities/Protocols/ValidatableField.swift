//
//  ValidateableField.swift
//  Utilities
//
//  Created by Mansoor Ali on 13/03/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//MARK:- Validate Types
public protocol CustomValidator {
	func validate(_ text: String) -> FieldState
}

public enum RegularExpression: String {
	case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
	case pin = ".{4,}"
	case iban = "[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{4}[0-9]{7}([a-zA-Z0-9]?){0,16}"
	case swiftCode = "^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$"
	case accountNumber = "^\\d{5,25}$"
	case accountTitle = "^([a-zA-Z]{2,}\\s[a-zA-z]+'?-?[a-zA-Z]{2,}\\s?([a-zA-Z]+)?)"
	/// at least 8 characters with at least one number
	case password = "^(?=.*\\d)(?=.*[a-zA-Z]).{8,72}$"
	case notEmpty = ".{1,}"
	case phoneNo = "^\\d{12}$"
    case phoneNoWithoutCountryCode = "^\\d{11}$"
	case nameWithWhiteSpaces = "[a-zA-Z]+(\\s+[a-zA-Z]+)*"
	case digitsOnly = "^[0-9]+$"
    
}


public enum Validator {
	case regx(RegularExpression)
	case custom(CustomValidator)
}

//MARK:- Validatable
public enum FieldState {
	case valid
	case invalid(String)
	case inprocess
//	case active
//	case inactive
	case none
}

public protocol ValidatableField {
	var validator: Validator? {get}
	var validationError: String {get}
	var validationState: BehaviorRelay<FieldState> { get }
	//var rxIsFirstReponder: BehaviorRelay<Bool> { get }
}

public extension ValidatableField where Self: UITextField {

	func bindText(disposeBg: DisposeBag) {
        self.rx.text.orEmpty.skip(1).map { [weak self] (text) -> FieldState? in
			guard let self = self, let type = self.validator else { return nil }
			switch type {
			case .regx(let regularExpression):
				/*if text.isEmpty {
					return  FieldState.active
				}else */if text.isValid(forExp: regularExpression.rawValue){
					return FieldState.valid
				}else {
					return .invalid(self.validationError)
				}
			case .custom(let customValidator):
				return customValidator.validate(text)
			}

		}.compactMap{$0}.bind(to: validationState).disposed(by: disposeBg)
	}
}

public extension ValidatableField where Self: UITextView {

	func bindText(disposeBg: DisposeBag) {
		/*self.rx.didChange.subscribe(onNext: { [weak self] (textView) in
			let text = self?.text ?? ""
			guard let self = self, let type = self.validator else {return}
			let state: FieldState
			switch type {
			case .regx(let regularExpression):
				if text.isValid(forExp: regularExpression.rawValue){
					state = .valid
				}else {
					state = .invalid(self.validationError)
				}
			case .custom(let customValidator):
				state = customValidator.validate(text)
			}
			self.validationState.accept(state)
		}).disposed(by: disposeBg)*/
	}
}

//MARK:- Form
public protocol FormInput {
	func reValidate()
	//func showError(error: String)
}

public class FormValidator {

	public struct FormResult {
		public let isValid: Bool
		public let invalidFields: [FormInput]
		public let errors:[String]
	}

	private var fields = [FormInput]()
	private var states = [Observable<FieldState>]()

	public init() { }
	
	public func addField(name: FormInput, state: Observable<FieldState>) {
		fields.append(name)
		states.append(state)
	}

	public func validate() -> Observable<FormResult> {
		for input in fields {
			input.reValidate()
		}
		return Observable.just("").withLatestFrom(Observable.combineLatest(states)).map { (list) -> FormResult in
			var index = -1
			var invalidFields = [FormInput]()
			let errors = list.map { [weak self] (state) -> String in
				index += 1
				switch state {
				case .invalid(let error):
					if let self = self {
						invalidFields.append(self.fields[index])
					}
					return error
				default:
					return "-1"
				}
			}.filter{$0 != "-1"}

			//raw text
			return FormResult(isValid: errors.isEmpty, invalidFields: invalidFields, errors: errors)
		}
	}
}
