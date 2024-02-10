//
//  SceneDelegate.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let sceneWindow = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: sceneWindow)

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    // the launcher view controller that implemented by view model
    private var viewController: ReportViewController {

        // implement network layer
        let network = Network(
            apiHandler: APIHandlerImp(),
            responseHandler: ResponseHandlerImp()
        )

        // implement post service
        let postService = PostsServiceImp(network: network)

        let calculationService = CalculationServiceImp()

        let dataProcessing =  DataProcessingImp(
            calculationService: calculationService
        )

        let userProcessing = UserProcessingImp(
            calculationService: calculationService
        )

        let userPostProcessing = UserPostProcessingImp(dataProcessing: dataProcessing)

        let userService = UserServiceImp(userProcessing: userProcessing, dataProcessing: dataProcessing)

        let reportService = ReportServiceImp(
            userService: userService,
            userPostProcessing: userPostProcessing
        )

        // implement view model
        let viewModel = ReportViewModel(
            serviceHandler: postService,
            reportService: reportService
        )

        // return view controller by implemented via view model
        return ReportViewController(viewModel: viewModel)
    }
}

