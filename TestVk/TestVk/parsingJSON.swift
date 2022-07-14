//
//  parsingJSON.swift
//  TestVk
//
//  Created by Максим Никитин on 7/14/22.
//

import Foundation


struct AppVK: Decodable {
    var name: String
    var description: String
    var link: String
    var icon_url: String
}

struct bodyJSON: Decodable{
    var services:[AppVK]
}

struct treeJSON: Decodable{
    var body: bodyJSON
}

class Api{
    func getApps(completion: @escaping ([AppVK]) -> ()){
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                let data = data
            else{ return }
            let apps = try! JSONDecoder().decode(treeJSON.self, from: data)
            DispatchQueue.main.async {
                completion(apps.body.services)
            }
            
        }
        .resume()
    }
}
