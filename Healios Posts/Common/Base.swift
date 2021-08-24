//
//  BaseUI.swift
//  Common UI
//
//  Created by Fahad Baig Saeed on 18/08/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Utilities
import Reusable
import SVProgressHUD
import SwiftMessages

//MARK: NavigationController


//MARK: NavigationBar
extension UINavigationBar {}

open class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationBar.applyPrimaryStyle()
        self.interactivePopGestureRecognizer?.delegate = self
        self.navigationBar.prefersLargeTitles = true
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

//MARK: BaseViewController
open class BaseViewController<ViewModel>: UIViewController {

    public var disposeBag = DisposeBag()
    public var viewModel: ViewModel!
    var topSafeArea: CGFloat = 0.0
    var bottomSafeArea: CGFloat = 0.0
    //Request Reponse
    public var progressView: ViewDisplayable?
    var loadingInsets: UIEdgeInsets = .zero
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        customizeUI()
        createLoadableViews()
        configureNavigationBar()
        configureNavigationItems()
        bindViewModel(vm: viewModel)
    }
    
    /// apply styling to ui elements and setup lists
    open func customizeUI() {
//        self.view.backgroundColor = Style.Color.Background.primary
    }
    
    /// configure navBar image
    open func configureNavigationBar() {
//        self.navigationController?.navigationBar.applyPrimaryStyle()
    }
    
    /// add navBarItems
    open func configureNavigationItems() {}

    /**
        creates loading,error view for api response
        * Default progress view is SimpleProgressView
        * Default error view is nil and displays popup
        * override this function to change loading view
    */
    public func createLoadableViews() {
        progressView = SimpleProgressView(frame: .zero)
    }

    /**
        Bind loadable loading, error, success to viewController
        * override this function if you want to perform custom action on error, loading or success
        - Parameter loadable: loadable class
    */
    open func bindLoadable(loadable: Loadable) {
        bindLoadingView(loading: loadable.loading)
        bindErrorView(error: loadable.error)
        bindSuccessView(success: loadable.success)
    }

    /**
        show/hide loadingView
        * override this function for custom loading behavior
    */
    open func bindLoadingView(loading: Observable<Bool>) {
        loading.subscribe(onNext: { [weak self] (loading) in
            guard let self = self else {return}
            if loading {
                SVProgressHUD.show()
//                self.progressView?.show(fromView: self.view, insets: self.loadingInsets, animated: true, completion: nil)
            }else {
                SVProgressHUD.dismiss()
                self.progressView?.hide(animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }

    /**
        show error popup from bottom
        * override this function for custom error behavior
        * triggred from bindLoadable
    */
    open func bindErrorView(error: Observable<String>) {
        error.subscribe(onNext: { (error) in
            SVProgressHUD.showError(withStatus: "Error")
//            SwiftMessages.showMessage(title: "", message: error, theme: .error)
        }).disposed(by: disposeBag)
    }

    /**
        show success popup from bottom
        * override this function for custom success behavior
        * triggred from bindLoadable
    */
    open func bindSuccessView(success: Observable<String>) {
        success.subscribe(onNext: { (msg) in
            SVProgressHUD.showError(withStatus: "Success")
//            SwiftMessages.showMessage(message: msg, theme: .success)
        }).disposed(by: disposeBag)
    }

    /// Bind viewModel to ui elemnts, bind ui inputs to viewModel
    /// - Parameter vm: view model
    open func bindViewModel(vm: ViewModel) {}

    /// add custom button to leftBarItem
//    public func addBackButton(image: UIImage? = UIImage(named: "backButton2")) {
//        let img = image ?? R.image.btnBack()
//        let btnBack = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(actBack))
//        self.navigationItem.leftBarButtonItem = btnBack
//    }
    /// custom button action
    @objc public func actBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureNavigationBar()
        appearanceUpdated(userInterfaceStyle: self.traitCollection.userInterfaceStyle)
    }

    /// configure items which donot  update automatically for Light/DarkMode
    open func appearanceUpdated(userInterfaceStyle: UIUserInterfaceStyle) {}
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        safeAreaHeight(topSafeArea: topSafeArea, bottomSafeArea: bottomSafeArea)
    }
    open func safeAreaHeight(topSafeArea:CGFloat,bottomSafeArea:CGFloat) {
        
    }
}

//MARK: BaseCollectionViewCell
open class BaseCollectionViewCell<ViewModel>: UICollectionViewCell {
    open var viewModel: ViewModel! {
        didSet {
            guard let vm = viewModel else {return}
            bindViewModel(vm: vm)
        }
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    open var disposeBag = DisposeBag()
    
    func customizeUI() {}
    open func bindViewModel(vm: ViewModel) {}
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        viewModel = nil
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        appearanceUpdated(userInterfaceStyle: self.traitCollection.userInterfaceStyle)
    }
    
    /// configure items which donot  update automatically for Light/DarkMode
    open func appearanceUpdated(userInterfaceStyle: UIUserInterfaceStyle) {
        /*
         switch self.traitCollection.userInterfaceStyle {
         case .dark:
         break
         default:
         break
         }
         */
    }
}


//MARK:- BaseTableViewCell
open  class BaseTableViewCell<ViewModel>: UITableViewCell {
    open var viewModel: ViewModel! {
        didSet {
            guard let vm = viewModel else {return}
            bindViewModel(vm: vm)
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    
    }
    open var disposeBag = DisposeBag()

    open func customizeUI() {
//        self.backgroundColor = Style.Color.Background.primary
    }
    open func bindViewModel(vm: ViewModel) {}

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        viewModel = nil
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        appearanceUpdated(userInterfaceStyle: self.traitCollection.userInterfaceStyle)
    }
    
    /// configure items which donot  update automatically for Light/DarkMode
    open func appearanceUpdated(userInterfaceStyle: UIUserInterfaceStyle) {
        /*
         switch self.traitCollection.userInterfaceStyle {
         case .dark:
         break
         default:
         break
         }
         */
    }
}

//MARK:- BaseView
open class SubView: UIView {

    public var disposeBag = DisposeBag()

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        appearanceUpdated(isDark: self.traitCollection.userInterfaceStyle == .dark)
    }

    open func appearanceUpdated(isDark: Bool) { }
}

class BaseTableView: UITableView {
    @IBInspectable var bgColor:UIColor?{
        didSet{
            self.backgroundColor = bgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    func customizeUI() {
        self.tableFooterView = UIView()
//        self.bgColor = CommonUI.Style.Color.Background.primary
    }
}

class BaseCollectionView: UICollectionView {
    @IBInspectable var bgColor:UIColor?{
        didSet{
            self.backgroundColor = bgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    func customizeUI() {
//        self.bgColor = CommonUI.Style.Color.Background.primary
    }
}



//class DropDownBgView: BaseView {
//    override func customizeUI() {
//        self.backgroundColor = UIColor.Aydo.Background.tertiary
//        self.layer.borderColor = UIColor(light: .white, dark: UIColor.Aydo.Static.mediumBg).cgColor
//        self.layer.cornerRadius = 5
//    }
//
//    override func appearanceUpdated() {
//        switch self.traitCollection.userInterfaceStyle {
//        case .dark:
//            self.layer.borderWidth = 1
//        default:
//            self.layer.borderWidth = 0
//        }
//    }
//
//    func addErrorEffect() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.Aydo.Highlight.primary.cgColor
//    }
//
//    func removeErrorEffect() {
//        self.layer.borderWidth = self.traitCollection.userInterfaceStyle == .dark ? 1 : 0
//    }
//}


//MARK: Helper Extensions
//extension UIView {
//    var isDarkMode: Bool {
//        switch self.traitCollection.userInterfaceStyle {
//        case .dark:
//            return true
//        default:
//            return false
//        }
//    }
//}
