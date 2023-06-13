//
//  FishViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import RxSwift

final class FishViewModel {
    
    private let service: Loader
    private let currentCalendar: CalendarDelegate
    private let fishesDataSubject = BehaviorSubject<[FishData]>(value: [])
    var fishesData: Observable<[FishData]> {
        return fishesDataSubject.asObservable()
    }
    let numberOfSections = 2
    private let disposeBag = DisposeBag()
    private let errorSubject = PublishSubject<Void>()
    var onError: Observable<Void> {
        return errorSubject.asObservable()
    }
    
    init(
        service: Loader = CreatureLoader(),
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.service = service
        self.currentCalendar = currentCalendar
    }
    
    func getFishesData() {
        service.getFishesData()
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let fishesData):
                    self.fishesDataSubject.onNext(fishesData)
                case .failure(_):
                    errorSubject.onNext(())
                }
            })
            .disposed(by: disposeBag)
    }
    
    func configureHeaderSection(with section: Int) -> String {
        section == 0 ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    func configureSectionCollectionView(with section: Int) -> Observable<Int> {
        section == 0 ? northernHemisphereFishes.map { $0.count } : southernHemisphereFishes.map { $0.count }
    }
    
    func makeFish(with section: Int, index: Int) -> Observable<FishData> {
        section == 0 ? northernHemisphereFishes.map { $0[index] } : southernHemisphereFishes.map { $0[index] }
    }
}

private extension FishViewModel {
    
    // Sorts the fishes from the northern hemisphere using the current month and time.
    var northernHemisphereFishes: Observable<[FishData]> {
        return fishesData
            .map { [weak self] fishesData in
                let (hour, month) = self?.currentCalendar.currentDate ?? (0, 0)
                return fishesData.filter {
                    $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
                }
            }
    }
    
    var southernHemisphereFishes: Observable<[FishData]> {
        return fishesData
            .map { [weak self] fishesData in
                let (hour, month) = self?.currentCalendar.currentDate ?? (0, 0)
                return fishesData.filter {
                    $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
                }
            }
    }
}
