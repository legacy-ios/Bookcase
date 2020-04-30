//
//  BookcaseView.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-30.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(BookcaseCell.self, forCellReuseIdentifier: BookcaseCell.identifier)
        configure()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.rowHeight = 120
    }
    
    private func autoLayout() {
        let guide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: guide.topAnchor),
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }

}

