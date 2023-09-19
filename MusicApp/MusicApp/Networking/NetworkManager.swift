//
//  NetworkManager.swift
//  MusicApp
//
//  Created by 최정은 on 2023/09/18.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
    
}

final class NetworkManager{
    
    static let shared = NetworkManager()
    
    // 싱글톤으로 만들 때 다른 곳에서 생성자 호출안되게끔
    private init() {}
    
    typealias NetworkCompletion = (Result <[Webtoon], NetworkError>) -> Void
    
    func fetchWebtoon(searchTerm: String, completion: @escaping NetworkCompletion){
       
       // let url = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        
        let searchURL = searchTerm == "" ? "\(WebtoonApi.requestUrl)" : "\(WebtoonApi.searchUrl)\(searchTerm)"
        
        print(searchURL)
        performRequest(with: searchURL) { result in
            completion(result)
        }
    }
    
    // 실제 Request하는 함수 (비동기적 실행 x===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        print(#function)
       
       // guard let url = URL(string: urlString) else { return }
        
        guard let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        let url = URL(string: encodedStr)!
        print(url.absoluteString)
        
        let session = URLSession(configuration: .default)
       
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error: Network Error")
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                print("Error: Data 없음")
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(musics))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    
   private func parseJSON(_ safeData: Data) -> [Webtoon]? {
        do{
           
            let str = String(decoding: safeData, as: UTF8.self)
           // dump(print(str))
            let musicArray = try JSONDecoder().decode(WebtoonData.self, from: safeData)
            return musicArray.webtoons
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
