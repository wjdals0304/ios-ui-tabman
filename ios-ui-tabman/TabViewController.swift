//
//  TabViewController.swift
//  ios-ui-tabman
//
//  Created by 김정민 on 2022/05/14.
//

import Tabman
import Pageboy
import UIKit
import SnapKit

final class TabViewController: TabmanViewController {
    
    //페이징 할 뷰 컨트롤러
    private var viewControllers: Array<UIViewController> = []
    private let home = HomeViewController()
    private let brand = BrandViewController()
    
    private let tempView = UIView()
    
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        [
            home,brand
        ].forEach { viewControllers.append($0) }
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tempView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        tempView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()

        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black // 선택 안되어 있을 때
            button.selectedTintColor = .blue // 선택 되어 있을 때
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 35 // 버튼 사이 간격
    
        bar.layout.transitionStyle = .snap // Customize
        
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))
        
    }
}

extension TabViewController : PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title:"Home")
        case 1 :
            return TMBarItem(title:"Brand")
        default :
            return TMBarItem(title:"0")
        }
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}
