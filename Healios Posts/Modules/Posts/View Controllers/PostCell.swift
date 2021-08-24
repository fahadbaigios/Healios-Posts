//
//  AllEventsViewCell.swift
//  Healios Posts
//
//  Created by Fahad Baig on 03/02/2021.
//

import UIKit
import Utilities
import Reusable
import Store
import RxSwift
import SDWebImage

public class PostCellViewModel: ViewModel {
    
    public struct Input {}
    
    public struct Output {
        let title: Observable<String>
        let body: Observable<String>
    }
    
    public let input = Input()
    public let output: Output
    private var disposeBag = DisposeBag()
    
    public init(title: String, body: String) {
        
        //Output
        output = Output(title: Observable.just(title), body: Observable.just(body))
        
    }
    
}

class PostCell: BaseTableViewCell<PostCellViewModel>, NibReusable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func customizeUI() {
        self.layer.cornerRadius = 5
    }
    
    override func bindViewModel(vm: PostCellViewModel) {
        vm.output.title.bind(to: title.rx.text).disposed(by: disposeBag)
        vm.output.body.bind(to: body.rx.text).disposed(by: disposeBag)
    }

}

