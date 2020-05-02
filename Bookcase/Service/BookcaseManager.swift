//
//  BookcaseManager.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import Foundation

protocol BookcaseManagerDelegate {
    func didUpdateBookcase(_ bookcaseManager: BookcaseManager, books: [Book])
    func didFailWithError(error: Error)
}

struct BookcaseManager {
    
    var delegate: BookcaseManagerDelegate?

    let requestUrl = "https://api.storytel.net/search?query=harry"

    func fetchBookcaseInfo(key: String) {
        
        performRequest(with: requestUrl)
    }
    
    private func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: request) {
                (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let book = self.parseJSON(safeData){
                        self.delegate?.didUpdateBookcase(self, books: book)
                    }
                }
            }
            
            task.resume()
        }
    }
    
   private func parseJSON(_ bookData: Data) -> [Book]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(BookData.self, from: bookData)
            var books = [Book]()
            decodedData.items.forEach { (item) in
                let title = item.title
                let author = item.authors.map{$0.name}.reduce("By: "){$0+$1}
                let narrator = item.narrators.map{$0.name}.reduce("With: "){$0+$1}
                let coverUrl = item.cover.url
                
                let book = Book(title: title, author: author, narrator: narrator, coverUrl: coverUrl, nextPageToken: decodedData.nextPageToken)
                books.append(book)
            }
            return books
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
