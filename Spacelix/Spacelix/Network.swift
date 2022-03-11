//
//  Network.swift
//  Spacelix
//
//  Created by BARIS UYAR on 9.03.2022.
//

import Foundation
import Apollo
import RxSwift

typealias Launch = LaunchListQuery.Data.Launch
typealias LaunchResponse = ([Launch], Error?, Bool)

protocol LaunchServiceContract {
    func fetchLaunches(offset: Int?, limit: Int?) -> Observable<LaunchResponse>
}

final class Network {
    static let shared = Network()
    static let store = ApolloStore()
    static let provider = DefaultInterceptorProvider(client: URLSessionClient(),
                                                     shouldInvalidateClientOnDeinit: true,
                                                     store: store)
    private(set) lazy var apollo: ApolloClient? = {
        guard let url =  URL(string: "https://api.spacex.land/graphql/") else { return nil }
        let transport = RequestChainNetworkTransport(interceptorProvider: Network.provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport, store: Network.store)
    }()
}

final class ApolloAPI: LaunchServiceContract {

    func fetchLaunches(offset: Int?, limit: Int?) -> Observable<LaunchResponse> {
        return Observable<LaunchResponse>.create { observer in
            Network.shared.apollo?.fetch(query: LaunchListQuery(Offset: offset, Limit: limit)) { result in
                DispatchQueue.main.async {
                    if case .success(let launchResult) = result {
                        if let resultList = launchResult.data?.launches {
                            let list = resultList.compactMap { launch in
                                return launch
                            }
                            observer.onNext((list, nil, resultList.count == 10))
                        }
                    } else if case .failure(let error) = result {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create {}
        }
    }
}
