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
    private var serviceManager = BookcaseServiceManager()
    private let bookcaseView = BookcaseView()
    private let headerView = BookcaseHeaderView()
    private var nextPageToken: String?
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        fetchBookcaseInfo()
    }
    
    private func configure() {
        bookcaseView.tableView.dataSource = self
        bookcaseView.tableView.delegate = self
        serviceManager.delegate = self
    }
    
    private func addSubViews() {
        view = bookcaseView
        view.addSubview(headerView)
    }
    
    private func fetchBookcaseInfo() {
        if !isLoading {
            isLoading = true
            serviceManager.fetchBookcaseInfo(nextPageToken: nextPageToken)
        }
    }
}

extension BookcaseViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.stretchHeight(scrollView)
    }
}

extension BookcaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = books.count - 1
        if !isLoading && indexPath.row == lastElement{
            fetchBookcaseInfo()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == books.count {
            return isLoading ? SpinnerCell.height : 0
        }
        
        return BookcaseCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == books.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: SpinnerCell.reuseIdentifier, for: indexPath) as! SpinnerCell
            cell.startSpin(isLoading)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookcaseCell.reuseIdentifier, for: indexPath) as! BookcaseCell
        cell.configureWithModel(book: books[indexPath.row])
        return cell
        
    }
}

extension BookcaseViewController: BookcaseServiceManagerDelegate {
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.showAlert(withMessage: error.localizedDescription)
        }
    }
    
    func didUpdateBookcase(_ bookcaseManager: BookcaseServiceManager, books: [Book]?) {
        if let books = books {
            if self.books.count > 0 {
                sleep(2)
            }
            DispatchQueue.main.async {
                self.isLoading = false
                self.books += books
                self.bookcaseView.tableView.reloadData()
                self.nextPageToken = books[books.startIndex].nextPageToken
                self.headerView.configureWithData(book: books[books.startIndex])
            }
        }
    }
}
