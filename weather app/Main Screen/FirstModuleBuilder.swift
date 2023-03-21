//
//  FirstModuleBuilder.swift
//  weather app
//
//  Created by Алексей Волобуев on 15.03.2023.
//

import Foundation

class FirstModuleBuilder {
    static func createFirstModule() -> FirstViewController {
        let viewController = FirstViewController()
        let router = Router()
        let presenter = Presenter(viewInput: viewController, router: router)
        viewController.viewOutputDelegate = presenter
        return viewController
    }
}
