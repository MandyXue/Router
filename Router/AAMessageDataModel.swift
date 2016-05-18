//
//  AAMessageDataModel.swift
//  Router
//
//  Created by FOWAFOLO on 16/5/17.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import JSQMessagesViewController

typealias JSQLocationMediaItemCompletionBlock = ()-> Void

class AAMessageDataModel: NSObject {
    
    var messages = NSMutableArray()
    var avatars = NSDictionary()
    var outgoingBubbleImageData = JSQMessagesBubbleImage()
    var incomingBubbleImageData = JSQMessagesBubbleImage()
    var users = NSDictionary()
    
    override init() {
        super.init()
        loadFakeMessages()
    }
    
    func loadFakeMessages() {
        let temp = JSQMessage(senderId: "Test1", senderDisplayName: "叫爸爸", date: NSDate.distantPast(), text: "It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com.")
        let fakeMessages: [JSQMessage] = [temp, temp, temp]
        self.messages = NSMutableArray(array: fakeMessages)
    }
}

extension AAMessageDataModel {
    
    func addPhotoMediaMessage() {
        
    }
    
    func addLocationMediaMessageCompletion(completion: JSQLocationMediaItemCompletionBlock) {
        
    }
    
    func addVideoMediaMessage() {
        
    }
    
    func addAudioMediaMessage() {
//        NSString * sample = [[NSBundle mainBundle] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
//        NSData * audioData = [NSData dataWithContentsOfFile:sample];
//        JSQAudioMediaItem *audioItem = [[JSQAudioMediaItem alloc] initWithData:audioData];
//        JSQMessage *audioMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
//        displayName:kJSQDemoAvatarDisplayNameSquires
//        media:audioItem];
//        [self.messages addObject:audioMessage];
        let sample = NSBundle.mainBundle().pathForResource("jsq_messages_sample", ofType: "m4a")
        if sample != nil {
            let audioData = NSData.dataWithContentsOfMappedFile(sample!)
//            let audioItem = JSQAudioMediaItem
        }
    }
}