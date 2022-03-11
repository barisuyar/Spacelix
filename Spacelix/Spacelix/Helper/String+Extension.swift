//
//  String+Extension.swift
//  Spacelix
//
//  Created by BARIS UYAR on 10.03.2022.
//

import Foundation

extension String {

    var thumbnailUrlString: String? {
        guard let videoID = components(separatedBy: "=").last else { return nil }
        return "https://i3.ytimg.com/vi/\(videoID)/hqdefault.jpg"
    }
}
