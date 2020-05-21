//
//YWeather
//UIImageView+load.swift
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping (_: Bool)->()) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(true)
                    }
                }
            } else {
                print("Error while loading icon.")
                completion(false)
            }
        }
    }
}
