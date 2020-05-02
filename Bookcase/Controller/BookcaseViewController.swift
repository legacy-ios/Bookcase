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
    private let spinner = SpinnerView()
    private var nextPageToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        fetchBookcaseInfo()
    }
    
    private func configure() {
        bookcaseView.tableView.dataSource = self
        bookcaseView.tableView.delegate = self
        manager.delegate = self
    }
    
    private func addSubViews() {
        view = bookcaseView
        bookcaseView.tableView.tableFooterView = spinner
        view.addSubview(headerView)
        
    }
    
    private func fetchBookcaseInfo() {
        manager.fetchBookcaseInfo(nextPageToken: nextPageToken)
    }
}

extension BookcaseViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.stretchHeight(scrollView)
    }
}

extension BookcaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return books.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BookcaseCell.reuseIdentifier, for: indexPath) as! BookcaseCell
            cell.cover.load(url: URL(string: books[indexPath.row].coverUrl)!)
            cell.title.text = books[indexPath.row].title
            cell.author.text = books[indexPath.row].author
            cell.narrator.text = books[indexPath.row].narrator
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SpinnerView.reuseIdentifier, for: indexPath) as! SpinnerView
            return cell
        }
        
    }
}

extension BookcaseViewController: BookcaseManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateBookcase(_ bookcaseManager: BookcaseManager, books: [Book]?) {
        
        if let books = books {
            self.books += books
            DispatchQueue.main.async {
                self.bookcaseView.tableView.reloadData()
                self.headerView.cover.load(url: URL(string: books[books.endIndex-1].coverUrl)!)
                self.headerView.title.text = books[books.endIndex-1].title
                self.nextPageToken = books[books.startIndex].nextPageToken
            }
        }
        
    }
}
