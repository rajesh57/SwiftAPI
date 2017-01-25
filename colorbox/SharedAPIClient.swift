

import Foundation

let demoBaseURLEndpoint = "bins/wwo5x"
let demoBaseURL = "https://api.myjson.com/"

let serverEndpoint = "videosrc/colors.json"
let serverBaseURL = "https://thatthinginswift.com/"

class SharedAPIClient {
    static let sharedClient = SharedAPIClient()

    func getColors(_ completion: @escaping ([ColorBox]) -> ()) {
        
        get(clientURLRequest(serverEndpoint)) { (success, object) in
            
            var colors: [ColorBox] = []

            if let object = object as? Dictionary<String, AnyObject> {
                
                if let results = object["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for result in results {
                        
                        if let color = ColorBox(json: result) {
                            
                            colors.append(color)
                        }
                    }
                }
            }
            completion(colors)
        }
    }

    
    func getCustomrdetails(_ completionHandler: @escaping ([CustomerDetails]) -> ()) {
        
        get(clientURLRequest(demoBaseURLEndpoint)) {success,object in
            
            var customerDetail: [CustomerDetails] = [] // Empty Array
            
            if  let object = object as? Dictionary<String,AnyObject> { // Response get from Dict
                
                if let resultResponse = object["CustomerDetails"] as? [Dictionary<String,AnyObject>] { // Dict to access "KEY"
                    
                    for customerResult in resultResponse { // Iterating loop adding to array.
                        
                        if let customerDetailsObj = CustomerDetails(json: customerResult) {
                            //customerDetailsObj.MobileNumber
                            customerDetail.append(customerDetailsObj)
                        }
                    }
                }
            }
            completionHandler(customerDetail)
        }
    }
    
    private func post(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", completion: completion)
    }
    
    private func put(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "PUT", completion: completion)
    }
    
    fileprivate func get(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }

    fileprivate func clientURLRequest(_ path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: demoBaseURL+path)!)

        return request
    }

    fileprivate func dataTask(_ request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method

        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        }) .resume()
    }
}
