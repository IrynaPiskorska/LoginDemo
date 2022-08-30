//
//  AppCoordinator.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 20.08.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel()
        viewModel.coordinatorDelegate = self
        let controller = LoginViewController(viewModel: viewModel)
        viewModel.viewDelegate = controller
        navigationController.setViewControllers([controller], animated: false)
    }
}

extension AppCoordinator: LoginViewModelCoordinatorDelegate {
    func navigateToProjectsList(vievModeL: LoginViewModel) {
        let viewModel = ProjectsListViewModel()
        let controller = ProjectsListViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
