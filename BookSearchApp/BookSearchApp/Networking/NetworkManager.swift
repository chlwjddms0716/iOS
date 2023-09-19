//
//  NetworkManager.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import Foundation

public enum NetworkError: Error{
    case networkingError
    case dataError
    case parseError
}

public struct NetworkManager{
    
    static let shared = NetworkManager()
    private init(){}
    
    typealias NetworkCompletion = (Result<[Book], NetworkError>) -> (Void)
    
    func fetchBook(completion: @escaping NetworkCompletion) {
        
        let url = "\(BookApi.allBookURL)&\(BookApi.apiKeyParam)&\(BookApi.sizeParam)"
        print(url)
        getBook(url) { result in
            completion(result)
        }
    }
    
    func searchBook(keyword: String, completion: @escaping NetworkCompletion){
        
        let url = "\(BookApi.searchBookURL)&\(BookApi.apiKeyParam)&\(BookApi.sizeParam)&keyword=\(keyword)"
        print(url)
        getBook(url) { result in
            completion(result)
        }
    }
    
    func getBook(_ searchUrl: String, completion: @escaping NetworkCompletion ){
        
        guard let url = URL(string: searchUrl) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){ (data, response, error) in
            
            if error != nil{
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let bookData = parseJSON(safeData){
                completion(.success(bookData))
                return
            }
            else
            {
                completion(.failure(.parseError))
                return
            }
        }.resume()
        
    }
    
    func parseJSON(_ bookData: Data) -> [Book]? {
        
        do {
            let bookData = try JSONDecoder().decode(ResponseData.self, from: bookData)
            
            var bookArray: [Book] = []
          
            for item in  bookData.response.docs{
                if let book = item.doc {
                    bookArray.insert(book, at: bookArray.count)
                }
            }
            
            return bookArray
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
