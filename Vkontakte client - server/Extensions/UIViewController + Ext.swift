//
//  UIViewController + Ext.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 04.08.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import UIKit

extension UIViewController {
    public func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
