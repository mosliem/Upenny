//
//  ExpesnsesChartVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/10/22.
//

import UIKit
import Charts
import BetterSegmentedControl

class TransactionsChartVC: UIViewController {
    
    
    @IBOutlet weak var totalSpentLabel: UILabel!
    @IBOutlet weak var dateIntervalLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var presenter: TranasactionsChartViewPresenter?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        presenter = TransactionsChartPresenter(view: self)
    }
    
    private func configureView(){
        
        configureWeekMonthSegment()
        configureTableView()
        configureBarChart()
        configureLeftSwipeGesture()
        configureRightSwipeGesture()
    }
    
    
    
    private func configureWeekMonthSegment() {
        
        let frame =  CGRect(x: 28, y: 390, width: 150, height: 45)
        
        let weekMonthSegment = BetterSegmentedControl(
            frame: frame,
            segments: LabelSegment.segments(
                withTitles: ["Week","Month"],
                normalTextColor: .lightGray,
                selectedTextColor: .black
            ),
            
            options: [
                .backgroundColor(.clear),
                .indicatorViewBackgroundColor(.white),
                .indicatorViewBorderWidth(0.4),
                .indicatorViewBorderColor(.lightGray),
                .cornerRadius(11),
                .animationSpringDamping(1.0)
            ]
        )
        
        weekMonthSegment.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        view.addSubview(weekMonthSegment)
    }
    
    private func configureBarChart(){
        setCharFonts()
        customYAxis()
        customXAxis()
        customChartBody()
        setChartBarShadow()
    }
    
    private func setCharFonts(){
        barChartView.noDataFont = .boldSystemFont(ofSize: 15)
        barChartView.xAxis.labelFont = .systemFont(ofSize: 15, weight: .medium)
        barChartView.rightAxis.labelFont = .systemFont(ofSize: 15, weight: .medium)
        barChartView.rightAxis.labelTextColor = .lightGray
        barChartView.xAxis.labelTextColor = .lightGray
    }
    
    private func customYAxis(){
        barChartView.rightAxis.gridLineWidth = 0
        barChartView.rightAxis.axisLineColor = .clear
    }
    
    private func customChartBody(){
        
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.leftAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.noDataText = "No expenses for this date interval"
    }
    
    private func setChartBarShadow(){
        barChartView.drawBarShadowEnabled = true
        barChartView.tintColor = .lightGray
    }
    
    private func customXAxis(){
        
        barChartView.xAxis.axisLineColor = .clear
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.gridLineWidth = 0
    }
    
    private func configureTableView(){
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: TotalCategoryExpenseTableViewCell.identifier, bundle: nil),
                                   forCellReuseIdentifier: TotalCategoryExpenseTableViewCell.identifier)
    }
    
    @objc private func segmentControlValueChanged(_ sender: BetterSegmentedControl){
        
        presenter?.didChangeSegementValue(index: sender.index)
    }
    
}


extension TransactionsChartVC {
    
    private func configureRightSwipeGesture(){
        
        let rightSwipe =  UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(gesture:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    private func configureLeftSwipeGesture(){
        
        let leftSwipe =  UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(gesture:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @objc private func didSwipe(gesture: UISwipeGestureRecognizer){
        
        switch gesture.direction{
        
        case .right:
            presenter?.slideChartRight()
            
        case .left:
            presenter?.slideChartLeft()
        default:
            break
        }
    }
    
    
}
