//
//  File.swift
//  Bookcase
//
//  Created by jungwooram on 2020-05-02.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class SpinnerView: UITableViewCell {
    
    static let reuseIdentifier = "SpinnerCell"

    let spinner = UIActivityIndicatorView()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureContents()
//        autoLayout()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.addSubview(spinner)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
