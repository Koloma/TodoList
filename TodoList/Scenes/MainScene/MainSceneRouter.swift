//
//  MainSceneRouter.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import UIKit

@objc protocol IMainSceneRouter {
}

protocol IMainSceneDataPassing {
	var dataStore: IMainSceneDataStore? { get }
}

class MainSceneRouter: NSObject, IMainSceneRouter, IMainSceneDataPassing {
	weak var viewController: MainSceneViewController?
	var dataStore: IMainSceneDataStore?
}
