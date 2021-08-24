//
//  DataStore.swift
//  Store
//
//  Created by Fahad Baig on 03/02/2021.
//

import Foundation
import RxSwift
import Moya
import UIKit
import Utilities
import RxRelay


public final class PostsStore {
 
    private lazy var realm = RealmController.shared.getHandshakeRealm()

    public let posts = BehaviorRelay<[PostMO]>(value: [])
	private let users = BehaviorRelay<[UserMO]>(value: [])
	private let comments = BehaviorRelay<[CommentMO]>(value: [])

    private var disposeBag = DisposeBag()
	private var loadingPosts = false

    public init() {
		fetchData()
    }

	//fetch missing data
	public func fetchData() {
		//load posts
		if !loadingPosts && PostMO.fetchAll().isEmpty {
			fetchPosts()
		} else {
			posts.accept(PostMO.fetchAll())
		}

		//load users
		if !loadingUsers && UserMO.fetchAll().isEmpty {
			fetchUsers()
		}else {
			users.accept(UserMO.fetchAll())
		}

		if !loadingComments && CommentMO.fetchAll().isEmpty {
			fetchComments()
		} else {
			comments.accept(CommentMO.fetchAll())
		}

	}

	public func getUser(userId: Int) -> Observable<UserMO> {
		users.map { users in
			users.filter{$0.id == userId}.first
		}.compactMap{$0}
	}

	public func getComments(id: Int) -> Observable<[CommentMO]> {
		comments.map { comment in
			comment.filter{$0.postId == id}
		}.compactMap{$0}
	}
	
	//Fetch posts from server
	private func fetchPosts() {
        let request: Single<[PostMO]> = NetworkManager.shared.newRequest(method: .get, task: .requestPlain, path: "/posts")
		loadingPosts = true
		request.subscribe { [weak self] (posts) in
			guard let self = self else {return}
			self.loadingPosts = false
			try? PostMO.loadFromArray(fromArray: posts, realm: self.realm)
			self.posts.accept(PostMO.fetchAll())
		} onError: { [weak self] error in
			self?.loadingPosts = false
		}.disposed(by: disposeBag)
    }

	private var loadingUsers = false
	private func fetchUsers() {
		let request: Single<[UserMO]> = NetworkManager.shared.newRequest(method: .get, task: .requestPlain, path: "/users")
		loadingUsers = true
		request.subscribe { [weak self] users in
			guard let self = self else {return}
			self.loadingUsers = false
			try? UserMO.loadFromArray(fromArray: users, realm: self.realm)
			self.users.accept(users)
		} onError: { [weak self] error in
			self?.loadingUsers = false
		}.disposed(by: disposeBag)
	}

	private var loadingComments = false
	private func fetchComments() {
		let request: Single<[CommentMO]> = NetworkManager.shared.newRequest(method: .get, task: .requestPlain, path: "/comments")
		loadingComments = true
		request.subscribe { [weak self] comments in
			guard let self = self else {return}
			self.loadingComments = false
			try? CommentMO.loadFromArray(fromArray: comments, realm: self.realm)
			self.comments.accept(comments)
		} onError: { [weak self] error in
			self?.loadingComments = false
		}.disposed(by: disposeBag)
	}
    
}
