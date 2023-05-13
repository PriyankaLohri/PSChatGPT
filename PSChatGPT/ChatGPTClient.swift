//
//  ChatGPTClient.swift
//  PSChatGPT
//
//  Created by Priyanka on 05/05/23.
//

import Foundation

import Alamofire

class ChatGPTClient {
    //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
    /*
     curl https://api.openai.com/v1/edits \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer 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" \
     -d '{
     "model": "text-davinci-edit-001",
     "input": "What day of the weke is it?",
     "instruction": "Fix the spelling mistakes"
     }'*/
    let baseURL = "https://api.openai.com/v1"
    let headers: HTTPHeaders = ["Authorization": "Bearer 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"]
    
    func callChatGPTAPI(parameters: [String: Any], url:String, completion: @escaping (Result<String, Error>) -> Void) {

        AF.request(baseURL + url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: ChatGPTResponse.self) { response in
                switch response.result {
                case .success(let chatGPTResponse):
                    completion(.success(chatGPTResponse.choices[0].text))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func editText(userEnteredText:String){
        
        let parameters: [String: Any] = [
            "model": "text-davinci-edit-001",
            "input": userEnteredText,
            "instruction": "Fix the spelling mistakes"
        ]
        self.callChatGPTAPI(parameters: parameters, url: "/edits", completion:
                            { result in
            switch result {
            case .success(let text):
                print(text)
            case .failure(let error):
                print(error.localizedDescription)
                }
            }
        )
    }
    
    
    func completeText(userEnteredText:String){
        
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": userEnteredText,
            "temperature":0.5,
            "max_tokens": 300
        ]
        self.callChatGPTAPI(parameters: parameters, url: "/completions", completion:
                                { result in
            switch result {
            case .success(let text):
                print(text)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        )
    }

    
    func caseStudy(userEnteredText:String){
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": userEnteredText,
            "temperature": 0.3,
            "max_tokens": 500,
            "top_p": 1.0,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0
        ]
        
            self.callChatGPTAPI(parameters: parameters, url: "/completions", completion: { result in
                switch result {
                case .success(let text):
                    print(text)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        )
    }
}



struct ChatGPTResponse: Decodable {
    let choices: [Choice]
    
    struct Choice: Decodable {
        let text: String
    }
}
