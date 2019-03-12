    func getJSONReponseAPI(){
        
        let headers = [
            "wsc-api-key": "your api key",
            "wsc-access-key": "your access key",
            "Content-Type": "application/json"
        ]
        let parameters = ["live_stream": [
            "name": "Test again ",
            "transcoder_type": "transcoded",
            "billing_mode": "pay_as_you_go",
            "broadcast_location": "asia_pacific_india",
            "encoder": "other_rtmp",
            "delivery_method": "push",
            "aspect_ratio_width": "1920",
            "aspect_ratio_height": "1080"
            ]] //as [String : Any]
        
        //This will convert your dict to jsonObject data
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        //API URL 
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cloud.wowza.com/api/v1.3/live_streams")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST" 
        request.allHTTPHeaderFields = headers // call headers here
        request.httpBody = postData // add postData which we converted from paramter dict to jsonObject above
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                
                //MARK : Get reponse with Body in JSON format from the API when status code is 201
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON) // This will print the json reponse in proper JSON format  
                }
                
            }
        })
        
        dataTask.resume()
    }
