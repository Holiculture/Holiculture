//
//  Ticketmanager.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/04.
//

import SwiftUI
import Alamofire

//enum NetworkResult<T> {
//    case success(T)
//    case failure(Error)
//}

struct TicketManager {
    
    static let shared = TicketManager()
    
    let HolicultureURL = Bundle.main.object(forInfoDictionaryKey: "Holiculture_API") as? String ?? ""
    
    // MARK: - 티켓 정보 전달
    func sendTicket(uuid: String, concert: String, address: String, date: String, seat: String, img: String) {
        
        let url = "\(HolicultureURL)ticket/add"
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST로 보낼 정보
        let params: [String: Any] = [
            "uuid": uuid, // Convert UUID to String
            "_id": -1,
            "concert": concert,
            "address": address,
            "date": date,
            "seat": seat,
            "img": img
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
    
    func getTicket(uuid: String, tickets: Binding<[TicketDataModel]>, completion: @escaping (Bool) -> Void) {
        print("티켓 불러오는 중 ... ")
        let url = "\(HolicultureURL)ticket/get"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json","uuid": uuid])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    if let jsonArray = value as? [[String: Any]] {
                        var newTickets: [TicketDataModel] = []
                        
                        for ticketInfo in jsonArray {
                            if let _id = ticketInfo["_id"] as? Int,
                               let concert = ticketInfo["concert"] as? String,
                               let address = ticketInfo["address"] as? String,
                               let date = ticketInfo["date"] as? String,
                               let seat = ticketInfo["seat"] as? String,
                               let posX = ticketInfo["posX"] as? String,
                               let posY = ticketInfo["posY"] as? String,
                               let img = ticketInfo["img"] as? String{
                                let newTicket = TicketDataModel(
                                    uuid: uuid,
                                    _id: _id,
                                    concert: concert,
                                    address: address,
                                    date: date,
                                    seat: seat,
                                    posX: posX,
                                    posY: posY,
                                    img: img
                                )
                                newTickets.append(newTicket)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            tickets.wrappedValue.removeAll()
                            tickets.wrappedValue.append(contentsOf: newTickets)
                            completion(true) // Call completion with success status
                        }
                    }
                } catch {
                    print("JSON parsing error: \(error)")
                    completion(false) // Call completion with failure status
                }
            case .failure(let error):
                if let statusCode = response.response?.statusCode, statusCode == 404 {
                    DispatchQueue.main.async {
                        tickets.wrappedValue.removeAll()
                        completion(true) // Call completion with success status
                    }
                }
                print("티켓 조회 Network error: \(error.localizedDescription)")
                completion(false) // Call completion with failure status
            }
        }
    }

    
    func deleteTicket(ticketId: Int, completion: @escaping (Bool) -> Void) {
        print("티켓 삭제 중 ... ")
        let url = "\(HolicultureURL)ticket/delete/\(ticketId)"
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success:
                print("티켓 삭제 완료")
                completion(true)
            case .failure(let error):
                print("티켓 삭제 Network error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    //postman에서 아직 작동이 되지않으므로 나중에 다시 해보기
    func editTicket(uuid: String, _id: Int, concert: String, address: String, date: String, seat: String, img: String, completion: @escaping (Bool) -> Void) {
        let url = "\(HolicultureURL)ticket/edit/\(_id)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        let params: [String: Any] = [
            "uuid": uuid, // UUID를 String으로 변환
            "_id": _id,
            "concert": concert,
            "address": address,
            "date": date,
            "seat": seat,
            "img": img
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
                        print("PUT 성공")
                        completion(true)
                    } else {
                        print("서버 응답 오류: \(statusCode)")
                        completion(false)
                    }
                }
            case .failure(let error):
                print("티켓 수정 error: \(error.errorDescription ?? "알 수 없는 오류")")
                completion(false)
            }
        }
    }

    
}


