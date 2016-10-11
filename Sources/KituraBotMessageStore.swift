//
//  KituraBotMessageStore.swift
//  KituraBotMessageStore
//
//  Created by Jacopo Mangiavacchi on 10/8/16.
//
//

import Foundation
import Kitura
import KituraBot
import SwiftyJSON
import LoggerAPI


// MARK KituraBotMessageStoreInMemory

/// Implement a simple KituraBotMessageStore plugin 
/// Store message in a in memory dictionary
/// Warning: it do not scale on different frontend deployment
public class KituraBotMessageStoreInMemory : KituraBotMessageStoreProtocol {
    private var messageStoreDictionary: [String : KituraBotMessage]

    //TODO: Add parameter for Message Store
    public init() {
        messageStoreDictionary = [String : KituraBotMessage]()
    }

    public func addMessage(_ message: KituraBotMessage) {
        log(message)
        messageStoreDictionary[message.messageId] = message
    }

    public func getMessage(messageId: String) -> KituraBotMessage? {
        return messageStoreDictionary[messageId]
    }

    public func getMessageAll(user: KituraBotUser) -> [KituraBotMessage] {
        //Filter channel + userid
        return messageStoreDictionary.values.filter({ (value: KituraBotMessage) -> Bool in
            return (value.user.channel == user.channel && value.user.userId == user.userId)
        })
    }
    
    
    public func getMessageAll(fromMessageId: String, user: KituraBotUser) -> [KituraBotMessage] {
        //get date from messageid
        if let date =  messageStoreDictionary[fromMessageId]?.timestamp {
            //Filter (channel + userid) + date
            return messageStoreDictionary.values.filter({ (value: KituraBotMessage) -> Bool in
                return (value.user.channel == user.channel && value.user.userId == user.userId && value.timestamp > date)
            })
        }

        //Else return empty array
        return [KituraBotMessage]()
    }
    
    
    public func getMessageAll(fromDate: String, user: KituraBotUser) -> [KituraBotMessage] {
        //convert fromDate in Date
        let dateFor = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFor.date(from: fromDate) {
            //Filter (channel + userid) + date
            return messageStoreDictionary.values.filter({ (value: KituraBotMessage) -> Bool in
                return (value.user.channel == user.channel && value.user.userId == user.userId && value.timestamp > date)
            })
        }
        
        //Else return empty array
        return [KituraBotMessage]()
    }

    
    
    private func log(_ message: KituraBotMessage) {
        switch message.messageType {
        case .request:
            print("==> Received Message: \(message.messageText) (\(message.messageId))")
        case .response:
            print("<== Sent Message: \(message.messageText) (\(message.messageId))")
        }
    }
}


