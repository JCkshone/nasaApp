//
//  ApodManager.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol IApodManager: class {
    func getApodRangeDate() ->  Observable<[ApodItem]>
}

class ApodManager: IApodManager {
    private let api = NetworkServices.share
    private var customObserver: AnyObserver<[ApodItem]>!
    private let setApodItem = PublishSubject<ApodItem>()
    private let disposeBag = DisposeBag()
    private var apodItems = [ApodItem]()
    private var datesForRequest = [String]()
    private var datePosition = 0
    
    init() {
         buildDatesForRequest()
        setupEvents()
    }
    
    func getApodRangeDate() -> Observable<[ApodItem]> {
        return Observable.create { observer in
            if self.customObserver == nil {
                self.customObserver = observer
                self.getApods()
            }
            
            return Disposables.create()
        }
    }
    
    func getApods() {
        api.get(type: ApodItem.self, date: getPositionDate()) { result in
            switch result {
              case .success(let item):
                  self.setApodItem.onNext(item)
              case .failure(let error):
                  print(error.localizedDescription)
              }
        }
    }
    
    
    
    private func setupEvents() {
        setApodItem.bind { item in
            self.apodItems.append(item)
            if self.datePosition == self.datesForRequest.count {
                self.customObserver.onNext(self.apodItems)
                return
            }
            
            self.getApods()
        }.disposed(by: disposeBag)
    }
    
    private func buildDatesForRequest() {
        guard let date = Calendar.current.date(byAdding: .day, value: ApplicationConstants.requestDay, to: Date()) else { return }
        datesForRequest = Date.dates(from: date, to: Date())
    }
    
    private func getPositionDate() -> String {
        let date = datesForRequest[datePosition]
        datePosition += 1
        return date
    }
}
