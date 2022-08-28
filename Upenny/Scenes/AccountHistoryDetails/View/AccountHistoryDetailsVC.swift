//
//  AccountHistoryDetailsVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/24/22.
//

import UIKit
import BetterSegmentedControl

class AccountHistoryDetailsVC: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var noHistoryLabel: UILabel!
    
    var presenter: AccountHistoryViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        presenter = AccountHistoryVCPresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    
    private func configureView(){
        configureNavBarView()
        configureBackButton()
        configureTransactionTypeSegment()
        configureTableView()
    }
    
    private func configureBackButton(){
        
        backButton.roundButtonWithShadows(
            cornerRadius: 10,
            shadowRadius: 5,
            shadowOpicity: 0.4,
            shadowOffset: CGSize(width: 0, height: 2.5),
            shadowColor: .lightGray
        )
    }
    
    private func configureNavBarView(){
        navBarView.backgroundColor = .white
        navBarView.layer.shadowColor = UIColor.lightGray.cgColor
        navBarView.layer.shadowRadius = 5
        navBarView.layer.shadowOpacity = 0.3
        navBarView.layer.shadowOffset = CGSize(width: 0, height: 2.5)
    }
    
    private func configureTableView(){
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(UINib(nibName: AccountHistoryTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: AccountHistoryTableViewCell.identifer)
    }
    
    private func configureTransactionTypeSegment() {
        
        let frame =  CGRect(x: 20, y: navBarView.bottom + 25, width: 300, height: 45)
        
        let weekMonthSegment = BetterSegmentedControl(
            frame: frame,
            segments: LabelSegment.segments(
                withTitles: ["All","Income","Expense"],
                normalFont: .systemFont(ofSize: 18, weight: .bold),
                normalTextColor: .lightGray,
                selectedFont: UIFont.systemFont(ofSize: 18, weight: .bold), selectedTextColor: .black
            ),
            
            options: [
                .backgroundColor(.clear),
                .indicatorViewBackgroundColor(.white),
                .indicatorViewBorderWidth(0.6),
                .indicatorViewBorderColor(.lightGray),
                .cornerRadius(11),
                .animationSpringDamping(1.0),
            ]
        )
        
        weekMonthSegment.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        view.addSubview(weekMonthSegment)
    }
    
    @objc private func segmentControlValueChanged(_ sender: BetterSegmentedControl){
        presenter?.filterSegementPressed(type: AccountHistoryFilterType.IntToFilterType(index: sender.index))
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        presenter?.backPressed()
    }
    
}
