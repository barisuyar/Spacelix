//
//  LaunchDetailVC.swift
//  Spacelix
//
//  Created by BARIS UYAR on 10.03.2022.
//

import UIKit

final class LaunchDetailVC: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    var launch: Launch?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = launch?.details
        titleLabel.text = launch?.missionName
        guard let urlString = launch?.links?.videoLink?.thumbnailUrlString else { return }
        ImageDownloader.shared.downloadImage(with: urlString,
                                             completionHandler: { [weak self] image, _ in
            guard let self = self,
                  let image = image else { return }
            self.imageView.image = image
        }, placeholderImage: UIImage(named: "launchPlaceholder"))
    }
}
