//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 16.01.22.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        if let window = window {
            let tabBarController = UITabBarController()
            let currentWeatherVC = MainWeatherController()
            let forecastWeatherVC = ForecastWeatherController()
            
            setup(tabbar: tabBarController, firstVC: currentWeatherVC, secondVC: forecastWeatherVC)
           
            tabBarController.viewControllers = [currentWeatherVC, forecastWeatherVC]

            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    //MARK: - Setup components
    private func setup(tabbar: UITabBarController,
                       firstVC: MainWeatherController,
                       secondVC: ForecastWeatherController) {
        firstVC.tabBarItem.title = "Today"
        firstVC.tabBarItem.image = UIImage(named: "today")
        firstVC.tabBarItem.selectedImage = UIImage(named: "today")
        
        secondVC.tabBarItem.title = "Forecast"
        secondVC.tabBarItem.image = UIImage(named: "forecast")
        secondVC.tabBarItem.selectedImage = UIImage(named: "forecast")
        
        tabbar.tabBar.tintColor = .white
        tabbar.tabBar.isTranslucent = false
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemGray3
        
        firstVC.tabBarItem.standardAppearance = appearance
        firstVC.tabBarItem.scrollEdgeAppearance = appearance
        
        secondVC.tabBarItem.standardAppearance = appearance
        secondVC.tabBarItem.scrollEdgeAppearance = appearance

        
        tabbar.selectedIndex = 0
    }



}

