//
//  File.swift
//  BatThree
//
//  Created by 林祔利 on 2023/7/12.
//

import Foundation

class GetInfo {
    static let shared = GetInfo()
    
    func getAllInfo (completion: @escaping(Result<[StationInfo],Error>) -> Void){
        let urlString = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
        
        guard let url = URL(string: urlString) else {return}
                
                URLSession.shared.dataTask(with: url) { data, URLResponse, error in
                    if let data = data {
                        do {
                            let resules = try JSONDecoder().decode([StationInfo].self, from: data)
                            completion(.success(resules))
                        } catch  {
                            completion(.failure(error))
                            print(error)
                        }
                    }
                }.resume()
    }
    
    
}
