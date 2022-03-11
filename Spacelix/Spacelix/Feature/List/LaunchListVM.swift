//
//  LaunchListVM.swift
//  Spacelix
//
//  Created by BARIS UYAR on 10.03.2022.
//

import Foundation
import RxSwift
import RxRelay

final class LaunchListVM {

    private var api: LaunchServiceContract?
    private let disposeBag = DisposeBag()
    private var page: Int = 0
    var list: [Launch] = []

    init(api: LaunchServiceContract) {
        self.api = api
    }

    func fetchLauchList() -> Observable<Error?> {
        return Observable<Error?>.create { [weak self] observer in
            guard let self = self else { return Disposables.create {} }
            self.api?.fetchLaunches(offset: self.page * 10, limit: 10)
                .subscribe(onNext: { [weak self] response in
                    guard let self = self else { return }
                    if response.2 {
                        self.page += 1
                    }
                    self.list += response.0
                    observer.onNext(nil)
                }, onError: { error in
                    observer.onNext(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create {}
        }
    }
}
