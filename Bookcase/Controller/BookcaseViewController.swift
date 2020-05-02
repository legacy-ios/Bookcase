//
//  ViewController.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseViewController: UIViewController {

    private var books = [Book]()
    private var manager = BookcaseManager()
    private let bookcaseView = BookcaseView()
    private let headerView = BookcaseHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        manager.fetchBookcaseInfo(key: "")
    }
    
    private func configure() {
        bookcaseView.tableView.dataSource = self
        bookcaseView.tableView.delegate = self
        manager.delegate = self
    }
    
    private func addSubViews() {
        view = bookcaseView
        view.addSubview(headerView)
    }
}

extension BookcaseViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.stretchHeight(scrollView)
    }
}

extension BookcaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookcaseCell.reuseIdentifier, for: indexPath) as! BookcaseCell
        cell.cover.load(url: URL(string: books[indexPath.row].coverUrl)!)
        cell.title.text = books[indexPath.row].title
        cell.author.text = books[indexPath.row].author
        cell.narrator.text = books[indexPath.row].narrator
        return cell
    }
}

extension BookcaseViewController: BookcaseManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateBookcase(_ bookcaseManager: BookcaseManager, books: [Book]) {
        self.books = books
        DispatchQueue.main.async {
            self.bookcaseView.tableView.reloadData()
            self.headerView.cover.load(url: URL(string: books[0].coverUrl)!)
        }
    }
}
