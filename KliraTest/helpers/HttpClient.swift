import Foundation

class HttpClient {
    
    private let session = URLSession.shared
    
    func makeRequest(url: String, event: String?, completion: @escaping  (_ data: Data)->Void) {
        let myUrl = URL(string: url)!
        let task = session.dataTask(with: myUrl, completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(response!)
                    return
            }

            guard let data = data else {
                    return
            }
            completion(data)
        })
        task.resume()
    }
    
    func handleServerError(_ response: URLResponse) {
        Events.send(key: EVENT_SERVER_ERROR, info: ["message":response])
    }
}
