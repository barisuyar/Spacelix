//
//  LaunchCell.swift
//  Spacelix
//
//  Created by BARIS UYAR on 9.03.2022.
//

import UIKit

final class LaunchCell: UICollectionViewCell {

    @IBOutlet private weak var launchImageView: UIImageView!
    @IBOutlet private weak var launchNameLabel: UILabel!
    
    func configure(with launch: Launch) {
        launchNameLabel.text = launch.missionName
        launchImageView.image = UIImage(named: "launchPlaceholder")
        guard let urlString = launch.links?.videoLink?.thumbnailUrlString else { return }
        ImageDownloader.shared.downloadImage(with: urlString, completionHandler: { [weak self] image, _ in
            guard let self = self,
                  let image = image else { return }
            self.launchImageView.image = image
        }, placeholderImage: UIImage(named: "launchPlaceholder"))
    }
}
