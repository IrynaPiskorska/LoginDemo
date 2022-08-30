//
//  Coordinator.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 20.08.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    func childDidFinish(_ coordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
