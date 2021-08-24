//
//  PostCommentsCell.swift
//  Healios Posts
//
//  Created by Fahad Baig on 24/08/2021.
//

import UIKit
import Utilities
import Reusable
import Store
import RxSwift
import SDWebImage

public class PostCommentsCellViewModel: ViewModel {

	public struct Input {}

	public struct Output {
		let name: Observable<String>
		let email: Observable<String>
		let body: Observable<String>
	}

	public let input = Input()
	public let output: Output
	private var disposeBag = DisposeBag()

	public init(name: String, email: String, body: String) {

		//Output
		output = Output(name: Observable.just(name), email: Observable.just(email), body: Observable.just(body))

	}

}

class PostCommentsCell: BaseTableViewCell<PostCommentsCellViewModel>, NibReusable {

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var body: UILabel!

	override func customizeUI() {
		self.layer.cornerRadius = 5
//        self.applyShadow(cornerRadius: 5)
	}

	override func bindViewModel(vm: PostCommentsCellViewModel) {
		vm.output.name.map{$0.capitalized}.bind(to: name.rx.text).disposed(by: disposeBag)
		vm.output.email.bind(to: email.rx.text).disposed(by: disposeBag)
		vm.output.body.bind(to: body.rx.text).disposed(by: disposeBag)
	}

}
