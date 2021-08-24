//
//  PostDetailViewController.swift
//  Healios Posts
//
//  Created by Fahad Baig on 11/03/2021.
//

import UIKit
import Utilities
import Reusable
import RxSwift

class PostDetailViewController: BaseViewController<PostDetailViewModel>, ViewModelBased, StoryboardSceneBased  {
    public static var sceneStoryboard: UIStoryboard = R.storyboard.posts()

	@IBOutlet weak var postTitle: UILabel!
	@IBOutlet weak var body: UILabel!
	@IBOutlet weak var posterName: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var tableHeaderView: UIView!
    override func customizeUI() {
//		tableView.tableHeaderView = tableHeaderView
		self.navigationItem.title = "Post Detail"
		tableView.delegate = self
    }
    
    override func bindViewModel(vm: PostDetailViewModel) {
		vm.output.title.bind(to: postTitle.rx.text).disposed(by: disposeBag)
		vm.output.body.bind(to: body.rx.text).disposed(by: disposeBag)
		vm.output.posterName.bind(to: posterName.rx.text).disposed(by: disposeBag)

		vm.output.comments.bind(to: tableView.rx.items(cellIdentifier: PostCommentsCell.reuseIdentifier, cellType: PostCommentsCell.self)) { (row,model,cell) in
			cell.viewModel = PostCommentsCellViewModel.init(name: model.name, email: model.email, body: model.body)
		}.disposed(by: disposeBag)
    }
}

extension PostDetailViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
		label.text = "Comments"

		let view = UIView(frame: label.frame)
		view.addSubview(label)
		view.backgroundColor = UIColor.systemGray5
		return view
	}
}
