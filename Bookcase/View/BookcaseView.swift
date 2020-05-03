//
//  BookcaseView.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-30.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        tableView.register(BookcaseCell.self, forCellReuseIdentifier: BookcaseCell.reuseIdentifier)
        tableView.register(SpinnerCell.self, forCellReuseIdentifier: SpinnerCell.reuseIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        self.addSubview(tableView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}

