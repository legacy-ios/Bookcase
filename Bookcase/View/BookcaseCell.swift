//
//  BookcaseCell.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseCell: UITableViewCell {
    
    static let reuseIdentifier = "BookcaseCell"

    let cover: UIImageView = {
        let coverImage = UIImageView()
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.backgroundColor = .lightGray
        return coverImage
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 21.0)
        title.numberOfLines = 1
        return title
    }()
    
    let author: UILabel = {
       let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.systemFont(ofSize: 17.0)
        author.textColor = .gray
        author.numberOfLines = 1
        return author
    }()
    
    let narrator: UILabel = {
        let narrator = UILabel()
        narrator.translatesAutoresizingMaskIntoConstraints = false
        narrator.font = UIFont.systemFont(ofSize: 17.0)
        narrator.textColor = .gray
        narrator.numberOfLines = 1
        return narrator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        autoLayout()
    }
    
    private func addContentView() {
        contentView.addSubview(cover)
        contentView.addSubview(title)
        contentView.addSubview(author)
        contentView.addSubview(narrator)
    }
    
    private func autoLayout() {
    
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            cover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            cover.widthAnchor.constraint(equalToConstant: 100),
            cover.heightAnchor.constraint(equalToConstant: 100),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: margin+5),
            title.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: margin),
            author.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            author.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            narrator.topAnchor.constraint(equalTo: author.bottomAnchor, constant: margin-5),
            narrator.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            narrator.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
