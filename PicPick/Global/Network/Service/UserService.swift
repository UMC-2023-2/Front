//
//  UserService.swift
//  PicPick
//
//  Created by Jaeuk on 2/17/24.
//

import Foundation
import Alamofire

class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void)
    {
        let url = APIConstants.loginURL //통신할 API 주소
        
        //HTTP Headers : 요청 헤더
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        //요청 바디
        let body : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        //요청서 //Request 생성
        //통신할 주소, HTTP메소드, 요청방식, 인코딩방식, 요청헤더
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData{
            response in //데이터 통신의 결과가 response에 담기게 된다
            switch response.result {
            case .success: //데이터 통신이 성공한 경우에
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(LoginResponse.self, by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func isDuplicate(email: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        let url = APIConstants.isDuplicateURL
        
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        let body: Parameters = [
            "email": email
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                let networkResult = self.judgeStatus(IsDuplicateResponse.self,by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus<T: Decodable>(_ decodeType: T.Type,by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300 : return isVaildData(decodeType.self, data: data)
        case 400..<500 : return .pathErr
        case 500..<600 : return .serverErr
        default : return .networkFail
        }
    }
    
    private func isVaildData<T: Decodable>(_ decodeType: T.Type, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode(decodeType.self, from: data) { return .success(decodedData as Any) }
        
        return .pathErr
    }
}
