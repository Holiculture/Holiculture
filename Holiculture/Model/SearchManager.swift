//
//  SearchManager.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/06.
//

import SwiftUI
import Alamofire

struct SearchManager {
    
    static let shared = SearchManager()
    
    // MARK: - 식당 정보 불러오기
    func getPlace(uuid: String, ticketId: Int, places: Binding<[PlaceDataModel]>, option: String, distance: String, completion: @escaping (Bool) -> Void) {
        print("주변 장소 불러오는 중 ... ")
        
        //let encodedConcert = concert.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = "https://holiculture.du.r.appspot.com/\(option)?ticketId=\(ticketId)&distance=\(distance)"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json","uuid": uuid])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    if let jsonArray = value as? [[String: Any]] {
                        var resultPlace: [PlaceDataModel] = []

                        for placeInfo in jsonArray {
                            if let place_name = placeInfo["place_name"] as? String,
                               let place_url = placeInfo["place_url"] as? String,
                               let category_name = placeInfo["category_name"] as? String,
                               let distance = placeInfo["distance"] as? String,
                               let road_address_name = placeInfo["road_address_name"] as? String,
                               let cate = placeInfo["cate"] as? String,
                               let img = placeInfo["img"] as? String,
                               let isLike = placeInfo["isLike"] as? Bool,
                               let x = placeInfo["x"] as? String,
                               let y = placeInfo["y"] as? String {
                                let newPlace = PlaceDataModel(
                                    place_name: place_name,
                                    place_url: place_url,
                                    category_name: category_name,
                                    distance: distance,
                                    road_address_name: road_address_name,
                                    cate: cate,
                                    img: img,
                                    isLike: isLike,
                                    x: x,
                                    y: y
                                )
                                resultPlace.append(newPlace)
                            }
                        }
                        DispatchQueue.main.async {
                            places.wrappedValue.removeAll()
                            places.wrappedValue.append(contentsOf: resultPlace)
                            print("장소 불러오기 완료")
                            printAllPlaceData(resultPlace)
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

func printAllPlaceData(_ places: [PlaceDataModel]) {
    for place in places {
        print("Place Name: \(place.place_name)")
        print("Place URL: \(place.place_url)")
        print("Category Name: \(place.category_name)")
        print("Distance: \(place.distance)")
        print("Road Address Name: \(place.road_address_name)")
        print("Category: \(place.cate)")
        print("Images: \(place.img)")
        print("isLike: \(place.isLike)")
        print("x: \(place.x)")
        print("y: \(place.y)")
        print("--------")
    }
}

