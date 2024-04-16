//
//  LoginCoordinator.swift
//  YeogiApa
//
//  Created by JinwooLee on 4/15/24.
//

import Foundation
import UIKit

final class UserCoordinator : Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var delegate : AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SignInUpViewController() // child root view controller
        vc.delegate = self
        self.navigationController.viewControllers = [vc]
    }
    
    // User Coordinator -> AppCoordinator -> Main Coordinator로 전환되는 과정
    func didLoggedIn() {
        delegate?.didLoggedIn(self)
    }
    
    // UserCoordinator의 하위 VC
    func kakaoLogin() {
        print("화면전환 ✅ - kakao")
    }
    
    func appleLogin() {
        print("화면전환 ✅ - apple")
    } 
    
    func emailLogin() {
        let child = EmailLoginCoordinator(navigationController: navigationController)
        child.delegate = self
        childCoordinators.append(child)
        child.start()
    }

}
