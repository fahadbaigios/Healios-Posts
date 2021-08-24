//
//  DashboardViewController.swift
//  Healios Posts
//
//  Created by Fahad Baig on 03/02/2021.
//

import UIKit
import Utilities
import Reusable
import RxSwift

class PostsViewController: BaseViewController<PostsViewModel>, ViewModelBased, StoryboardSceneBased  {
    public static var sceneStoryboard: UIStoryboard = R.storyboard.posts()

    @IBOutlet weak var tableView: UITableView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let index = tableView.indexPathForSelectedRow else {return}
		tableView.deselectRow(at: index, animated: true)
	}
	
    override func customizeUI() {
//		tableView.delegate = self
		self.navigationItem.title = "Posts"
	}

    override func bindViewModel(vm: PostsViewModel) {
        bindLoadable(loadable: vm.output)
        
        vm.output.dataSource.bind(to: tableView.rx.items(cellIdentifier: PostCell.reuseIdentifier, cellType: PostCell.self)) { (row,model,cell) in
            cell.viewModel = PostCellViewModel.init(title: model.title, body: model.body)
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.bind(to: vm.input.itemSelected).disposed(by: disposeBag)
    }
}

