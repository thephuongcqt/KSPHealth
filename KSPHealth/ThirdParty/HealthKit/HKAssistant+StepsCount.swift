//
//  HealthKitAssistant+StepsCount.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/31/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import HealthKit

extension HKAssistant{
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }
    
    func retrieveStepCount(startDate: Date, endDate: Date, completion: @escaping (_ stepRetrieved: Double, _ startDate: Date, _ endDate: Date) -> Void) {
        let stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval)
        
        query.initialResultsHandler = { query, results, error in
            if error != nil {
                print(error?.localizedDescription ?? "Authorize Error")
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate, to: endDate) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        let startDate = statistics.startDate
                        let endDate = statistics.endDate
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        completion(steps, startDate, endDate)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
}
