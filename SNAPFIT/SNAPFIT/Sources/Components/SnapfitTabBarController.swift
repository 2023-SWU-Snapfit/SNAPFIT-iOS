//
//  SnapfitTabBarController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/15.
//

import UIKit

final class SnapfitTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    enum Text {
        static let homeTitle = "홈"
        static let homeIconName = "tabBarHome"
        static let favoriteListTitle = "관심 목록"
        static let favoriteListIconName = "tabBarHeart"
        static let reservationTitle = "예약 관리"
        static let reservationIconName = "tabBarReserve"
        static let mypageTitle = "마이 페이지"
        static let mypageIconName = "tabBarMypage"
        static let selected = "Selected"
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabBarItemStyle()
        self.setTabBarItems()
        self.setUI()
    }
    
    // MARK: Methods
    
    private func makeTabVC(vc: UIViewController, tabBarTitle: String, tabBarImg: String, tabBarSelectedImg: String) -> UIViewController {
        
        vc.tabBarItem = UITabBarItem(
            title: tabBarTitle,
            image: UIImage(named: tabBarImg)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: tabBarSelectedImg)?.withRenderingMode(.alwaysOriginal)
        )
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        return vc
    }
    
    private func setTabBarItems() {
        self.delegate = self
        
        let homeTab: UIViewController = self.makeTabVC(
            vc: BaseNavigationController(rootViewController: HomeViewController()),
            tabBarTitle: Text.homeTitle,
            tabBarImg: Text.homeIconName,
            tabBarSelectedImg: Text.homeIconName + Text.selected
        )
        homeTab.tabBarItem.tag = 0
        
        let favoriteListTab: UIViewController  = self.makeTabVC(
            vc: BaseNavigationController(rootViewController: FavoriteListViewController()),
            tabBarTitle: Text.favoriteListTitle,
            tabBarImg: Text.favoriteListIconName,
            tabBarSelectedImg: Text.favoriteListIconName + Text.selected
        )
        favoriteListTab.tabBarItem.tag = 1
        
        let reservationTab: UIViewController  = self.makeTabVC(
            vc: BaseNavigationController(rootViewController: ReservationViewController()),
            tabBarTitle: Text.reservationTitle,
            tabBarImg: Text.reservationIconName,
            tabBarSelectedImg: Text.reservationIconName + Text.selected
        )
        reservationTab.tabBarItem.tag = 2
        
        let mypageTab: UIViewController = self.makeTabVC(
            vc: BaseNavigationController(rootViewController: MypagePhotographerViewController()), // TODO: 마이페이지 vc 넣기
            tabBarTitle: Text.mypageTitle,
            tabBarImg: Text.mypageIconName,
            tabBarSelectedImg: Text.mypageIconName + Text.selected
        )
        reservationTab.tabBarItem.tag = 3
        
        let tabs = [homeTab, favoriteListTab, reservationTab, mypageTab]
        self.setViewControllers(tabs, animated: true)
    }
    
    private func setTabBarItemStyle() {
        self.tabBar.tintColor = .sfBlack100
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.r12], for: .normal)
    }
    
    private func setUI() {
        self.tabBar.standardAppearance.backgroundColor = .sfWhite
        UITabBar.clearShadow()
        self.tabBar.layer.applyShadow(color: UIColor.shadowDefault, alpha: 0.16, x: 0, y: -9, blur: 18)
        self.modalPresentationStyle = .fullScreen
    }
    
    func hideTabBar() {
        self.tabBar.isHidden = true
    }
    
    func showTabBar() {
        self.tabBar.isHidden = false
    }
}
