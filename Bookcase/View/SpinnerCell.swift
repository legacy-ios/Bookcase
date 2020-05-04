//
//  File.swift
//  Bookcase
//
//  Created by jungwooram on 2020-05-02.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class SpinnerCell: UITableViewCell {
    
    static let reuseIdentifier = "SpinnerCell"
    static let height = CGFloat(60.0)
    
    private let spinner = UIActivityIndicatorView()
    
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
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        contentView.backgroundColor = .clear
        contentView.addSubview(spinner)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func startSpin(_ isLoading: Bool) {
        isLoading ? spinner.startAnimating() : spinner.stopAnimating()
    }

}
