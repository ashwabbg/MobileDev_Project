import Foundation
import SwiftUI

struct Record : Codable{
    var records : [Event]
}

struct Event : Codable, Identifiable{
    var id : String
    var createdTime: String
    var fields : Fields
}

protocol RequestFactoryProtocol {
    func createRequest(urlStr: String) -> URLRequest
    func getFurnitureList(callback: @escaping ([Event]?, String?) -> Void)
}

class RequestFactory : RequestFactoryProtocol {
    
    static let shared = RequestFactory()
        
    private init() {}
    
    func createRequest(urlStr: String) -> URLRequest {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        let accessToken = "patikQ2NLt8ZuefWF.bab4360644fa68db943fec3ff9db7a0bb990674f092136422b3a0be9212e229d"
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getFurnitureList(callback: @escaping ([Event]?, String?) -> Void) {
        let session = URLSession(configuration: .default)
        let request = createRequest(urlStr: "https://api.airtable.com/v0/apps3Rtl22fQOI9Ph/%F0%9F%93%86%20Schedule?view=Full%20schedule")
        
        session.dataTask(with: request){ data, response, error in
            guard error == nil, let data = data else {
                callback(nil, "no data")
                return
            }
            guard let responsehttp = response as? HTTPURLResponse, responsehttp.statusCode == 200 else {
                callback(nil, "bad Gateway")
                return
            }
            guard let result = try? JSONDecoder().decode(Record.self, from: data) else {
                callback(nil, String(data: data, encoding: .utf8))
                return
            }
            callback(result.records, "all good")
        }.resume()
    }
}
                                                                                                                                                                                                                                                                                       
