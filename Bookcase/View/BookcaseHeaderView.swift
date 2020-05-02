//
//  BookcaseHeaderView.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseHeaderView: UIView {

    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 30.0)
        return title
    }()
    
    let cover: UIImageView = {
        let corver = UIImageView()
        corver.translatesAutoresizingMaskIntoConstraints = false
        corver.contentMode = .scaleAspectFill
        corver.clipsToBounds = true
        corver.backgroundColor = .lightGray
        return corver
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubview() {
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterial)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = cover.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cover.addSubview(blurView)
        self.addSubview(cover)
        self.addSubview(title)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor),
            cover.bottomAnchor.constraint(equalTo: bottomAnchor),
            cover.trailingAnchor.constraint(equalTo: trailingAnchor),
            cover.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func stretchHeight(_ scrollView: UIScrollView){
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y,100),440)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}
