//
//  NetworkService.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/14/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import Foundation

class NetworkService {
    
    var theToken: String?
    
//    init(Token: String) {
//        theToken = Token
//    }
   
    func getName() -> String {
        return UserDefaults.standard.string(forKey: "username")!
    }
    
    func fetchToken(user: Login) {
        let url = URL(string: "https://obscure-crag-65480.herokuapp.com/login")!
        var request = URLRequest(url: url)
        request.httpBody = try! JSONEncoder().encode(user)
        request.httpMethod = "POST"
        let task = URLSession(configuration: .ephemeral).dataTask(with: request) { (data, response, error) in
            self.theToken = try! JSONDecoder().decode(Token.self, from: data!).token!
            UserDefaults.standard.set(self.theToken, forKey: "token")
        }
        task.resume()
    }
    
    func getToken() -> String {
        return theToken!
    }
    
    
    func getUserList() -> [String] {
        let urlUsers = URL(string: "https://obscure-crag-65480.herokuapp.com/users")!
        var userList = [""]
        var request2 = URLRequest(url: urlUsers)
        request2.addValue(theToken!, forHTTPHeaderField: "token")
        request2.httpMethod = "GET"
        
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: request2) { (d, response, error) in
            userList = try! JSONDecoder().decode([String].self, from: d!)
            
        }
        getTask.resume()
        return userList
    }
    
    func getMessages() -> [Message] {
        let urlMessages = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")!
        var messages: [Message] = []
        var request3 = URLRequest(url: urlMessages)
        request3.addValue(theToken!, forHTTPHeaderField: "token")
        request3.httpMethod = "GET"
        
        let getMTask = URLSession(configuration: .ephemeral).dataTask(with: request3) { (d, response, error) in
            messages = try! JSONDecoder().decode([Message].self, from: d!)
            
        }
        getMTask.resume()
        return messages
    }
    
    func postMessage(message: Message) {
        let urlMessages2 = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")! //different for post?
        var requestPM = URLRequest(url: urlMessages2)
        requestPM.addValue(theToken!, forHTTPHeaderField: "token")
        requestPM.httpBody = try! JSONEncoder().encode(message) //need a way to declare message struct outside of getMTask
        requestPM.httpMethod = "POST"
        
        let postMTask = URLSession(configuration: .ephemeral).dataTask(with: requestPM) { (d, response, error) in
            let response = try! JSONDecoder().decode([String].self, from: d!)
        }
        postMTask.resume()
    }
    
    func getDirect() -> [Direct] {
        let url = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
        var directs: [Direct] = []
        var request = URLRequest(url: url)
        request.addValue(theToken!, forHTTPHeaderField: "token")
        request.httpMethod = "GET"
        
        let directTask = URLSession(configuration: .ephemeral).dataTask(with: request) { (d, response, error) in
            directs = try! JSONDecoder().decode([Direct].self, from: d!)
        }
        directTask.resume()
        return directs
    }
    
    func postDirect(directM: Direct) {
        let url = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
        var request = URLRequest(url: url)
        request.addValue(theToken!, forHTTPHeaderField: "token")
        request.httpBody = try! JSONEncoder().encode(directM)
        request.httpMethod = "POST"
        
        let postD = URLSession(configuration: .ephemeral).dataTask(with: request) { (d, response, error) in
        }
        postD.resume()
    }
    
    func postLike(messageID: String) {
        let message = LikedMessage(likedMessageID: messageID)
        let url = URL(string: "https://obscure-crag-65480.herokuapp.com/like")!
        var request = URLRequest(url: url)
        request.addValue(theToken!, forHTTPHeaderField: "token")
        request.httpBody = try! JSONEncoder().encode(message)
        request.httpMethod = "POST"
        
        let likeTask = URLSession(configuration: .ephemeral).dataTask(with: request) { (d, response, error) in
            
        }
        likeTask.resume()
    }
    
}
