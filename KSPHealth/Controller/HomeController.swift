//
//  HomeController.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class HomeController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    var stepsDic: [Date: Double] = [:]
    var sortedArr: [(Date, Double)] = []
    lazy var dbHelper: IDBHealper = {
        return RealmHelper.shared
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l = barChartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let rightAxis = barChartView.rightAxis
//        rightAxis.axisMinimum = 0
//
        let leftAxis = barChartView.leftAxis
//        leftAxis.axisMinimum = 0
//
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        rightAxis.enabled = false
        leftAxis.enabled = false
        
        //Get data from server
        DemoService.share.getPostList(with: [:]) { (result) in
            if let list = result{
                var rList = [RPost]()
                for item in list {
                    let post = RPost(post: item)
                    rList.append(post)
                }
                //Save data to local database
                self.dbHelper.save(items: rList, completion: { (success, error) in
                    if let error = error{
                        print(error.localizedDescription)
                    } else{
                        // Get Step count from Health Kit
                        self.getStepCount()
                        //Get data from local database
                        self.dbHelper.getAll(objectType: RPost.self, completion: { (posts, error) in
                            if let error = error{
                                print(error)
                            } else{
                                
                            }
                        })
                    }
                })
            }
        }                
    }
    
    func getStepCount(){
        let assistant = HKAssistant.shared
        assistant.authorizeRepository { (authorized, error) in
            guard authorized else{
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            print("HealthKit Successfully Authorized.")
            let endDate = Date()
            let startDate = Calendar.current.date(byAdding: .day, value: -14, to: endDate)!
            
            assistant.retrieveStepCount(startDate: startDate, endDate: endDate) { (steps, startDate, endDate) in
                self.stepsDic[endDate] = steps
                DispatchQueue.main.async {
                    self.barChartUpdate()
                }
            }
        }
    }
    
    func barChartUpdate () {
        sortedArr = stepsDic.sorted(by: { (firstItem, secondItem) -> Bool in
            return firstItem.key < secondItem.key
        })
        
        var count = 0.0
        var entries: [BarChartDataEntry] = []
        
        for (_, value) in sortedArr{
            let entry = BarChartDataEntry(x: count, y: value)
            entries.append(entry)
            count += 1
        }
        
        let dataSet = BarChartDataSet(values: entries, label: "14 days recently")
        let data = BarChartData(dataSets: [dataSet])
        barChartView.data = data
        barChartView.chartDescription?.text = "Number of steps in day"
        // Color
        dataSet.colors = ChartColorTemplates.vordiplom()
        // Refresh chart with new data
        barChartView.notifyDataSetChanged()
    }
    
    
    @IBAction func onButtonFitbitSelected(_ sender: Any) {
        let fitbit = FitbitAssistant.shared
        fitbit.fetchData { (data, success) in
            if success{
                print(data)
            }
        }
    }
    
    @IBAction func onButtonPulsenseSelected(_ sender: Any) {
        let loginService = LoginService()
        let loginControllerViewModel = LoginControllerViewModel(loginService)
        let loginController = LoginController.create(with: loginControllerViewModel)
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
}

extension HomeController: IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        let date = sortedArr[Int(value)].0
        let result = dateFormatter.string(from: date)
        return result
    }
}

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd"
    return dateFormatter
}()


