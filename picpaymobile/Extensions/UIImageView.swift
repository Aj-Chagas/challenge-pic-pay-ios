//
//  UIImageView.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 02/05/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
