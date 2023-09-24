//
//  LikeManager.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/17.
//

import SwiftUI
import Alamofire

struct LikeManager {
    
    static let shared = LikeManager()
    
    func sendLike(uuid: String, placeData: PlaceDataModel) {
        print("좋아요 등록 중 ... ")
        let url = "https://holiculture.du.r.appspot.com/like/add"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST로 보낼 정보
        let params: [String: Any] = [
            "uuid": uuid,
            "_id": -1,
            "place_name": placeData.place_name,
            "place_url": placeData.place_url,
            "category_name": placeData.category_name,
            "distance": placeData.distance,
            "road_address_name": placeData.road_address_name,
            "cate": placeData.cate,
            "img": placeData.img,
            "x" : placeData.x,
            "y" : placeData.y
            
        ]
        
        // httpBody에 parameters 추가
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).response { response in
            switch response.result {
            case .success(_):
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                        print("POST 성공")
                    } else {
                        print("서버 응답 오류: \(statusCode)")
                    }
                }
            case .failure(let error):
                print("티켓 전송 error : \(error.errorDescription ?? "Unknown Error")")
            }
        }
    }
    
    func sendIsLike(uuid: String, placeData: LikeDataModel) {
        print("좋아요 등록 중 ... ")
        let url = "https://holiculture.du.r.appspot.com/like/add"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST로 보낼 정보
        let params: [String: Any] = [
            "uuid": uuid,
            "_id": -1,
            "place_name": placeData.place_name,
            "place_url": placeData.place_url,
            "category_name": placeData.category_name,
            "distance": placeData.distance,
            "road_address_name": placeData.road_address_name,
            "cate": placeData.cate,
            "img": placeData.img,
            "isLike": placeData.isLike,
            "x": placeData.x,
            "y": placeData.y
        ]
        
        // httpBody에 parameters 추가
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).response { response in
            switch response.result {
            case .success(_):
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                        print("POST 성공")
                    } else {
                        print("서버 응답 오류: \(statusCode)")
                    }
                }
            case .failure(let error):
                print("티켓 전송 error : \(error.errorDescription ?? "Unknown Error")")
            }
        }
    }
    
    func deleteLike(uuid: String, address: String) { 
        print("좋아요 삭제 중 ... ")
        
        if let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            let url = "https://holiculture.du.r.appspot.com/like/delete/\(encodedAddress)"
            
            AF.request(url, method: .delete, encoding: JSONEncoding.default,
                       headers: ["Content-Type": "application/json", "uuid": uuid])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        print("좋아요 삭제 완료")
                    case .failure(let error):
                        print("좋아요 삭제 Network error: \(error.localizedDescription)")
                    }
                }
        } else {
            print("주소 URL 인코딩에 실패했습니다.")
        }
    }
    
    func getLike(uuid: String, likes: Binding<[LikeDataModel]>, completion: @escaping (Bool) -> Void){
        print("좋아요 불러오는 중 ... ")
        let url = "https://holiculture.du.r.appspot.com/like/get"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json","uuid": uuid])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    if let jsonArray = value as? [[String: Any]] {
                        var newLikes: [LikeDataModel] = []
                        
                        for likeInfo in jsonArray {
                            if let _id = likeInfo["_id"] as? Int,
                               let uuid = likeInfo["uuid"] as? String,
                               let place_name = likeInfo["place_name"] as? String,
                               let place_url = likeInfo["place_url"] as? String,
                               let category_name = likeInfo["category_name"] as? String,
                               let distance = likeInfo["distance"] as? String,
                               let road_address_name = likeInfo["road_address_name"] as? String,
                               let cate = likeInfo["cate"] as? String,
                               let img = likeInfo["img"] as? String,
                               let isLike = likeInfo["isLike"] as? Bool,
                               let x = likeInfo["x"] as? String,
                               let y = likeInfo["y"] as? String {
                                let newLike = LikeDataModel(
                                    uuid: uuid,
                                    _id: _id,
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
                                newLikes.append(newLike)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            likes.wrappedValue.removeAll()
                            likes.wrappedValue.append(contentsOf: newLikes)
                            completion(true)
                        }
                    }
                } catch {
                    print("JSON parsing error: \(error)")
                    completion(false)
                }
                
            case .failure(let error):
                if let statusCode = response.response?.statusCode, statusCode == 404 {
                    DispatchQueue.main.async {
                        likes.wrappedValue.removeAll()
                        completion(true)
                    }
                }
                print("좋아요 조회 Network error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func printAllLikeData(_ likes: [LikeDataModel]) {
        for place in likes {
            print("Place Name: \(place.place_name)")
            print("Place URL: \(place.place_url)")
            print("Category Name: \(place.category_name)")
            print("Distance: \(place.distance)")
            print("Road Address Name: \(place.road_address_name)")
            print("Category: \(place.cate)")
            print("Images: \(place.img)")
            print("x: \(place.x)")
            print("y: \(place.y)")
            print("--------")
        }
    }
    
    
    
}

