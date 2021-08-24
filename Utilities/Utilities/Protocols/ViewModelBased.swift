//
//  ViewModelBased.swift
//  Common
//
//  Created by Taimour Tanveer on 11/12/2018.
//  Copyright © 2018 Techtix co. All rights reserved.
//

import Foundation
import RxSwift
import Reusable

public protocol ViewModel {
    /**
    Each View Model should define its own Input type. The Input type should contain all the properties that are to be used to feed data to the view model.
     
     - Note: Suggested type for *Input* is **struct** that contains an observer for each input.
     
     - Important: All members of *Input* must be **write only**. Recommended type is **AnyObserver\<E\>**. When using any other type make sure to select a type that cannot be subscribed to avoid View Model Hacking
     */
    associatedtype Input
    
    /**
    Each View Model should define its own output type. The output type should contain all the properties that the view model has to feed to its view
     
     - Note: Suggested type for *Output* is **struct** that contains an observable for each input.
     
     - Important: All members of *Output* must be **read only**. Recommended type is **Observable\<E\>** or **Driver\<E\>**. When using any other type make sure to select a type that does not accept an event to avoid View Model Hacking
     */
    associatedtype Output
    
    ///Each View Model Should have a public input property of the associated type *Input* that can be used to provide input to the View Model
    var input:Input {get}
    
    ///Each View Model Should have a public output property of the associated type *Output* that can be used to show the output of the View Model
    var output:Output {get}
    
    ///Each view model must declare its disposeBag to be used with rx subscriptions to deinitialize subscriptions when the view model is destroyed
//    var disposeBag: DisposeBag {get}
    
    //Note: Viewmodels should only use These three public properties. All other properties of the View Model (if any) should only be private
}

/// Protocol to Define Views based Views on view models. Conformance to this protocol makes it necessary for the conforming classes to have a property named *viewModel* of an associated type conforming to the *ViewModel* protocol. Conformance to this class also provides the View an initializer its view model.
public protocol ViewModelBased: class {
    associatedtype ViewModelType: ViewModel // To ensure that the class used as view model conforms to the view model protocol
    var viewModel: ViewModelType! { get set }
}

public extension ViewModelBased where Self: UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}

public extension ViewModelBased where Self: StoryboardSceneBased & UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}

///Ensures implementation of Services for view model
public protocol ServiceBased {
	associatedtype ServiceType
	var services: ServiceType { get }
}

public struct LoadingOutput {
	public var loading = ReplaySubject<Bool>.create(bufferSize: 1)
	public var error = ReplaySubject<String>.create(bufferSize: 1)
	public var success = PublishSubject<String>()

	public init() { }
}

public protocol Loadable {
	var loadingOutput: LoadingOutput {get}
}

public extension Loadable {
	var loading: ReplaySubject<Bool> {loadingOutput.loading}
	var error: ReplaySubject<String> {loadingOutput.error}
	var success: PublishSubject<String> {loadingOutput.success}
}

