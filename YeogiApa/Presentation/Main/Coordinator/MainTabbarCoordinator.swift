//
//  MainCoordinator.swift
//  YeogiApa
//
//  Created by JinwooLee on 4/18/24.
//

import UIKit

final class MainTabbarCoordinator : Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator : AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabbarController = MainTabBarController()
        
        let boardNavigationController = UINavigationController()
        let boardCoordinator = BoardCoordinator(navigationController: boardNavigationController)
        boardCoordinator.parentCoordinator = self
        
        
        let settingNavigationController = UINavigationController()
        let settingCoordinator = SettingCoordinator(navigationController: settingNavigationController)
        settingCoordinator.parentCoordinator = self
        
        // tabbar 설정 및 child 추가
        tabbarController.viewControllers = [boardNavigationController, settingNavigationController]
        navigationController.pushViewController(tabbarController, animated: true)
        navigationController.isNavigationBarHidden = true
        
        childCoordinators.append(boardCoordinator)
        childCoordinators.append(settingCoordinator)
        
        boardCoordinator.start()
        settingCoordinator.start()
    }
    
    func resetLogined(_ coordinator : BoardCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        parentCoordinator?.resetLoggedIn(self)
    }
    
    deinit {
        print(#function, "-MainTabbarCoordinator ✅")
    }
    
}