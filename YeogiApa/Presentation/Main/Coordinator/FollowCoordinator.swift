//
//  FollowCoordinator.swift
//  YeogiApa
//
//  Created by JinwooLee on 5/5/24.
//

import UIKit

final class FollowCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator : ProfileCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func start(userID : String, me : Bool) {
        let vc = FollowTabmanViewController(viewControllersList: followChildViewController(userID: userID, me: me), category: FollowCategory.allCases)
        vc.parentCoordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension FollowCoordinator {
    private func followChildViewController(userID:String, me:Bool) -> Array<RxBaseViewController> {
        
        let category = FollowCategory.allCases
        var viewControllersList: Array<RxBaseViewController> = []

        category.forEach {
            let vc = FollowViewController(userID: userID, me: me, follower: $0.followers, following: $0.following)
            vc.parentCoordinator = self
            viewControllersList.append(vc)
        }
        
        return viewControllersList
    }
}
