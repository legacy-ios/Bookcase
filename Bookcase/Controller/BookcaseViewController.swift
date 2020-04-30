//
//  ViewController.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class BookcaseViewController: UIViewController {

    var manager = BookcaseManager()
    var books = [Book]()
    
    private let tableView: BookcaseView = {
        let tableView = BookcaseView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        addSubView()
        
        manager.delegate = self
        manager.fetchBookcaseInfo(key: "")
            
    }
    
    private func configure() {
        tableView.dataSource = self
    }
    
    private func addSubView() {
        //view.addSubview(tableView)
        self.view = tableView
    }
}

extension BookcaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookcaseCell.identifier, for: indexPath) as! BookcaseCell
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
        dump(books)
        self.books = books
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print(self.view.subviews)
        }
    }
}
