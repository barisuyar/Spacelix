//
//  LaunchServiceMock.swift
//  SpacelixTests
//
//  Created by BARIS UYAR on 11.03.2022.
//

import Foundation
import RxSwift
@testable import Spacelix

final class LaunchServiceMock: LaunchServiceContract {

    var launchList: [Launch] = []

    func fetchLaunches(offset: Int?, limit: Int?) -> Observable<LaunchResponse> {
        let launches = "launchList".loadJson()
        if let list = launches["launches"] as? [[String:Any?]] {
            launchList = list.compactMap({ dictionary in
                let links = dictionary["links"] as? [String: Any?]
                let videoLink = links?["video_link"] as? String
                return Launch(details: dictionary["details"] as? String,
                              missionName: dictionary["mission_name"] as? String,
                              links: Launch.Link(videoLink: videoLink), id: nil)
            })
        }
        return .create { observer in
            observer.onNext((self.launchList, nil, true))
            return Disposables.create {}
        }
    }
}
