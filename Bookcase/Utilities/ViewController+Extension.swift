//
//  ViewController+Extension.swift
//  Bookcase
//
//  Created by jungwooram on 2020-05-03.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
