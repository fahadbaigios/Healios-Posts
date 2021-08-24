//
//  DashboardViewModel.swift
//  Healios Posts
//
//  Created by Fahad Baig on 03/02/2021.
//

import Foundation
import Utilities
import RxSwift
import RxFlow
import RxRelay
import Store

public class PostsViewModel: ViewModel, Stepper {
 
    public struct Input {
		public var itemSelected: AnyObserver<IndexPath>
	}
    
    public struct Output: Loadable {
        public var loadingOutput = LoadingOutput()
        public let dataSource: Observable<[PostMO]>
    }
    
	public var input : Input
    public var output : Output
    private var disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    
    public init(store: PostsStore) {

		let itemSelected = PublishSubject<IndexPath>()

		input = Input(itemSelected: itemSelected.asObserver())
        output = Output(dataSource: store.posts.asObservable())

        //item selected from posts view
		itemSelected.withLatestFrom(store.posts) { (indexPath, posts) -> PostMO in
			return posts[indexPath.row]
		}.subscribe(onNext: { [weak self] (selectedPost) in
			self?.trigger(step: .postDetail(selectedPost))
		}).disposed(by: disposeBag)

    }

}
