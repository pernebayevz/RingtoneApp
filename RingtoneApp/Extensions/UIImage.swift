//
//  UIImage.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit

extension UIImage {
    static func fromGif(named: String) -> [UIImage] {
        guard let path = Bundle.main.path(forResource: named, ofType: "gif") else {
            print("Gif does not exist at that path")
            return []
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return [] }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        return images
    }
}
