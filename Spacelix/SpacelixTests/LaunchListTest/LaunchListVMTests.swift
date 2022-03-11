//
//  LaunchListVMTests.swift
//  SpacelixTests
//
//  Created by BARIS UYAR on 3.03.2022.
//

import XCTest
import RxSwift
@testable import Spacelix

final class LaunchListVMTests: XCTestCase {

    private var disposeBag = DisposeBag()
    let sut = LaunchListVM(api: LaunchServiceMock())

    func test_LaunchListCount_ShouldEqual10() {
        XCTAssertEqual(sut.list.count, 0)
        fetchLaunches()
        XCTAssertEqual(sut.list.count, 10)
    }

    private func fetchLaunches() {
        let fetchLaunchesExpectation = expectation(description: "fetchLaunches")
        sut.fetchLauchList().subscribe(onNext: { error in
            if error == nil {
                fetchLaunchesExpectation.fulfill()
            }
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
