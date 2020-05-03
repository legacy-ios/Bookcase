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
        let alert = UIAlertController(title: "Warnning", message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
