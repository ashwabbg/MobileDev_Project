import Foundation
import SwiftUI

protocol RequestFactoryProtocol {
    func createRequest(urlStr: String) -> URLRequest
    func getEventList(callback: @escaping ([Event]?, String?) -> Void)
    func getSpeakerList(callback: @escaping ([Speaker]?, String?) -> Void)
}

class RequestFactory : RequestFactoryProtocol {
    
    static let shared = RequestFactory()
        
    private init() {}
    
    // Connect to the DB
    func createRequest(urlStr: String) -> URLRequest {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        let accessToken = "patikQ2NLt8ZuefWF.bab4360644fa68db943fec3ff9db7a0bb990674f092136422b3a0be9212e229d"
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    // Retrieve the list of speakers by calling the AirTable DB
    func getEventList(callback: @escaping ([Event]?, String?) -> Void) {
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
            guard let result = try? JSONDecoder().decode(RecordEvent.self, from: data) else {
                callback(nil, "Error when parsing data (wrong data type)")
                return
            }
            callback(result.records, "all good")
        }.resume()
    }
    
    // Retrieve the list of speakers by calling the AirTable DB
    func getSpeakerList(callback: @escaping ([Speaker]?, String?) -> Void) {
        let session = URLSession(configuration: .default)
        let request = createRequest(urlStr: "https://api.airtable.com/v0/apps3Rtl22fQOI9Ph/%F0%9F%8E%A4%20Speakers?view=All%20speakers")
        
        session.dataTask(with: request){ data, response, error in
            guard error == nil, let data = data else {
                callback(nil, "no data")
                return
            }
            guard let responsehttp = response as? HTTPURLResponse, responsehttp.statusCode == 200 else {
                callback(nil, "bad Gateway")
                return
            }
            guard let result = try? JSONDecoder().decode(RecordSpeaker.self, from: data) else {
                callback(nil, "Error when parsing data (wrong data type)")
                return
            }
            callback(result.records, "all good")
        }.resume()
    }
}
