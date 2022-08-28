
//  Created by mohamedSliem on 8/10/22.

import UIKit

class TabBarController: UITabBarController {

    var customTabBarView = UIView(frame: .zero)
    var presenter: TabBarPresenter?


    let addExpenseButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TabBarPresenter(tabBarView: self)
        
        self.navigationController?.navigationBar.isHidden = true
        tabBar.tintColor = #colorLiteral(red: 0.3464263678, green: 0.3468263149, blue: 0.838334024, alpha: 1)
        
        setupTabBarNavigatoin()
        addCustomTabBarView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupTabBarFrame()
        setupButton()

    }
    
    
    //MARK:- Private functions
   
    private func setupButton(){
    
        addExpenseButton.frame = CGRect(x: view.bounds.width / 2 - 30, y: view.frame.size.height - 110 , width: 60, height: 60)
        
        let image = UIImage(systemName: "plus")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .bold))
        addExpenseButton.setImage(image, for: .normal)
        addExpenseButton.tintColor = .white
        addExpenseButton.backgroundColor = #colorLiteral(red: 0.3464263678, green: 0.3468263149, blue: 0.838334024, alpha: 1)
        
        addExpenseButton.addTarget(self, action: #selector(didTapAddExpensesButton), for: .touchUpInside)
        view.addSubview(addExpenseButton)

    }
    
    private func setupTabBarFrame(){
        
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 60
        tabBarFrame.origin.y = view.frame.size.height - 90
        tabBarFrame.size.width = UIScreen.main.bounds.width - 50
        tabBarFrame.origin.x = 25
        tabBar.frame = tabBarFrame

        tabBar.itemPositioning = .automatic
        tabBar.layer.cornerRadius = 15
        tabBar.clipsToBounds = true
        customTabBarView.frame = tabBar.frame
    
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        
        customTabBarView.backgroundColor = UIColor.systemFill
        customTabBarView.layer.cornerRadius = 15
        customTabBarView.layer.masksToBounds = false
        
        customTabBarView.layer.shadowColor = UIColor.darkGray.cgColor
        customTabBarView.layer.shadowOpacity = 1
        customTabBarView.layer.shadowRadius = 20
        
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
    }
    
    //MARK:- Tab bar Navigation
    
    private func setupTabBarNavigatoin(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dailyExpensesVC = storyboard.instantiateViewController(withIdentifier: "DailyExpensesVC") as! DailyTransactionsVC
        let TransactionsChartVC = storyboard.instantiateViewController(withIdentifier: "TransactionsChartVC") as! TransactionsChartVC
        
        let dailyExpensesVCNav = UINavigationController(rootViewController: dailyExpensesVC)
        let expensesChartVCNav = UINavigationController(rootViewController: TransactionsChartVC)
        
        dailyExpensesVCNav.navigationBar.isHidden = true
        expensesChartVCNav.navigationBar.isHidden = true
        
        dailyExpensesVCNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName:"creditcard.fill" ), tag: 1)
        expensesChartVCNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.bar.fill"), tag: 1)
    
        dailyExpensesVCNav.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -5, right: 0)

        
        setViewControllers([dailyExpensesVCNav,expensesChartVCNav], animated: true)
        
    }
    
    @objc private func didTapAddExpensesButton(){
        presenter?.didTapAddTransaction()
    }
    
}

extension TabBarController: TabBarViewProtocol{
    
    func moveToAddTransactionVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddExpensesVC") as! AddTransacionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
