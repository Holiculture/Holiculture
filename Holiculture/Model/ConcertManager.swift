//
//  ConcertManager.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/20.
//

import SwiftUI
import Alamofire

struct ConcertManager {
    
    static let shared = ConcertManager()
    
    let HolicultureURL = Bundle.main.object(forInfoDictionaryKey: "Holiculture_API") as? String ?? ""
    
    // MARK: - 식당 정보 불러오기
    func getConcertList(concerts: Binding<[ConcertDataModel]>,date: String, completion: @escaping (Bool) -> Void) {
        print("콘서트 리스트 불러오는 중 ... ")
        
        let encodedDate = date.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = "\(HolicultureURL)art?date=\(encodedDate)"
        print(url)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    if let jsonArray = value as? [[String: Any]] {
                        var resultConcert: [ConcertDataModel] = []
                        
                        for concertInfo in jsonArray {
                            if let _id = concertInfo["_id"] as? Int,
                               let title = concertInfo["title"] as? String,
                               let startDate = concertInfo["startDate"] as? String,
                               let endDate = concertInfo["endDate"] as? String,
                               let titleImg = concertInfo["titleImg"] as? String,
                               let location = concertInfo["location"] as? String,
                               let cate = concertInfo["cate"] as? String,
                               let address = concertInfo["address"] as? String,
                               let summary = concertInfo["summary"] as? String,
                               let cast = concertInfo["cast"] as? String,
                               let crew = concertInfo["crew"] as? String,
                               let runtime = concertInfo["runtime"] as? String,
                               let age = concertInfo["age"] as? String,
                               let producer = concertInfo["producer"] as? String,
                               let price = concertInfo["price"] as? String,
                               let time = concertInfo["time"] as? String,
                               let openrun = concertInfo["openrun"] as? String,
                               let subImgs = concertInfo["subImgs"] as? [String]{
                                let newConcert = ConcertDataModel(
                                    _id: _id,
                                    title: title,
                                    startDate: startDate,
                                    endDate: endDate,
                                    titleImg: titleImg,
                                    location: location,
                                    cate: cate,
                                    address: address,
                                    summary: summary,
                                    cast: cast,
                                    crew: crew,
                                    runtime: runtime,
                                    age: age,
                                    producer: producer,
                                    price: price,
                                    time: time,
                                    openrun: openrun,
                                    subImgs: subImgs
                                )
                                resultConcert.append(newConcert)
                            }
                        }
                        DispatchQueue.main.async {
                            concerts.wrappedValue.removeAll()
                            concerts.wrappedValue.append(contentsOf: resultConcert)
                            print("콘서트 목록 불러오기 완료")
                            printAllConcertData(resultConcert)
                            completion(true)
                        }
                    }
                } catch {
                    print("JSON parsing error: \(error)")
                    completion(false)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

}

func printAllConcertData(_ concerts: [ConcertDataModel]) {
    for concert in concerts {
        print("_id: \(concert._id)")
        print("title: \(concert.title)")
        print("startDate: \(concert.startDate)")
        print("endDate: \(concert.endDate)")
        print("img: \(concert.titleImg)")
        print("location: \(concert.location)")
        print("cate: \(concert.cate)")
        print("address: \(concert.address)")
        print("--------")
    }
}

