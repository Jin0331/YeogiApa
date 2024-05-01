//
//  BoardTabmanViewController.swift
//  YeogiApa
//
//  Created by JinwooLee on 4/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxViewController
import Tabman
import Pageboy

final class BoardTabmanViewController: TabmanViewController, TMBarDataSource {
    
    let baseView = BoardView()
    var parentCoordinator : BoardCoordinator?
    private let viewControllers: Array<RxBaseViewController>
    private let category : [Category]

    init(viewControllersList : Array<RxBaseViewController>, category : [Category], productId : String, limit : String){
        self.viewControllers = viewControllersList
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureView()
        super.viewDidLoad()
    }
}

//MARK: - Tabman 관련 사항
extension BoardTabmanViewController : PageboyViewControllerDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = category[index].rawValue
        
        return TMBarItem(title: title)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func configureView() {
        view.backgroundColor = DesignSystem.commonColorSet.white
        
        self.dataSource = self

        //MARK: - BaseView
        view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // Create bar
        let bar = TMBar.ButtonBar()
//        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)

        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: baseView, layout: nil))
    }
}