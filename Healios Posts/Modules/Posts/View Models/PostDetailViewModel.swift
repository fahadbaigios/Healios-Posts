//
//  PostDetailViewModel.swift
//  Healios Posts
//
//  Created by Fahad Baig on 11/03/2021.
//

import Foundation
import Utilities
import RxSwift
import RxFlow
import RxRelay
import Store

public class PostDetailViewModel: ViewModel, Stepper {
 
    public struct Input {}
    
    public struct Output: Loadable {
        public var loadingOutput = LoadingOutput()
		let title: Observable<String>
		let body: Observable<String>
		let posterName: Observable<String>
		let comments: Observable<[CommentMO]>
    }
    
    public var input : Input
    public var output : Output
    private var disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    
	public init(post: PostMO, store: PostsStore) {
        
        input = Input()

		let poster = store.getUser(userId: post.userId)
		let comments = store.getComments(id: post.id)
		output = Output(title: Observable.just(post.title), body: Observable.just(post.body), posterName: poster.map{"Posted By: "+$0.name.capitalized}, comments: comments)

    }
    
}

