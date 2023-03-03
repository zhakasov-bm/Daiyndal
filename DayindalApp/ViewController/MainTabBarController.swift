//
//  MainTabBarController.swift
//  DayindalApp
//
//  Created by Bekzhan
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
    }

    private func generateTabBar() {
        let vc1 = generateVC(viewController: MainViewController(), image: UIImage(named: "main-tab"))
        let vc2 = generateVC(viewController: ExamViewController(), image: UIImage(named: "test-tab"))

//        vc2.viewDidLoad()
        
        viewControllers = [vc1, vc2]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        
        return viewController
    }
    
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width, height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainBlue.cgColor
        
        tabBar.tintColor = .mainOrange
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
