//
//  BookcaseCell.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseCell: UITableViewCell {
    
    static let identifier = "BookcaseCell"

    let cover: UIImageView = {
        let coverImage = UIImageView()
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        //coverImage.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return coverImage
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        //title.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.numberOfLines = 1
        return title
    }()
    
    let author: UILabel = {
       let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        //author.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        author.font = UIFont.systemFont(ofSize: 18)
        author.textColor = .gray
        author.numberOfLines = 1
        return author
    }()
    
    let narrator: UILabel = {
        let narrator = UILabel()
        narrator.translatesAutoresizingMaskIntoConstraints = false
        //narrator.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        narrator.font = UIFont.systemFont(ofSize: 18)
        narrator.textColor = .gray
        narrator.numberOfLines = 1
        return narrator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
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
            cover.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
            cover.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            cover.widthAnchor.constraint(equalToConstant: 100),
            cover.heightAnchor.constraint(equalToConstant: 100),
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
            title.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: margin),
            author.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            author.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            narrator.topAnchor.constraint(equalTo: author.bottomAnchor, constant: margin),
            narrator.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: margin),
            narrator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
