//
//  LaunchListVC.swift
//  Spacelix
//
//  Created by BARIS UYAR on 3.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class LaunchListVC: UICollectionViewController {

    private lazy var dataSource = configureDataSource()
    private let disposeBag = DisposeBag()
    var viewModel = LaunchListVM(api: ApolloAPI())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Launch List"
        configureLayout()
        collectionView.dataSource = dataSource
        fetch()
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self,
                      let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchDetailVC") as? LaunchDetailVC else { return }
                controller.launch = self.viewModel.list[indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.list.count - 1 else { return }
        fetch()
    }

    private func fetch() {
        viewModel.fetchLauchList()
            .subscribe(onNext: { _ in
                DispatchQueue.main.async { [weak self] in
                    self?.updateSnapshot(animatingChange: true)
                }
            } , onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    private func configureLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width
            let imageWidth = width - 16
            let imageHeight = imageWidth * 0.75
            layout.itemSize = CGSize(width: width, height: imageHeight + 48)
            layout.estimatedItemSize = .zero
        }
    }

    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Launch> {
        UICollectionViewDiffableDataSource<Section, Launch>(collectionView: collectionView) { (collectionView, indexPath, launch) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCell", for: indexPath) as? LaunchCell else { return nil }
            cell.configure(with: launch)
            return cell
        }
    }

    private func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Launch>()
        snapshot.appendSections([.launches])
        snapshot.appendItems(viewModel.list, toSection: .launches)
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
}
