//
//  CacheManager.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import Foundation

public enum CacheManagerResult<T> {
    case success(T)
    case failure
}

class CacheManager {

    static let shared = CacheManager()
    private let fileManager = FileManager.default
    private lazy var mainDirectoryUrl: URL = {

    let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()
    
    private init() {}

    func getFileWith(url: URL, completionHandler: @escaping (CacheManagerResult<URL>) -> Void ) {
        let file = directoryFor(url: url)

        //return file path if already exists in cache directory
        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(CacheManagerResult.success(file))
            return
        }

        DispatchQueue.global().async {
            if let videoData = NSData(contentsOf: url) {
                videoData.write(to: file, atomically: true)

                DispatchQueue.main.async {
                    completionHandler(CacheManagerResult.success(file))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(CacheManagerResult.failure)
                }
            }
        }
    }

    private func directoryFor(url: URL) -> URL {
        let fileURL = url.lastPathComponent
        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
        return file
    }
}
