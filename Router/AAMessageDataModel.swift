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
    
    static let kJSQDemoAvatarDisplayNameSquires = "Jesse Squires"
    static let kJSQDemoAvatarIdSquires = "053496-4509-289"
    
    var messages = NSMutableArray()
    var avatars = NSDictionary()
    var outgoingBubbleImageData : JSQMessagesBubbleImage!
    var incomingBubbleImageData : JSQMessagesBubbleImage!
    var users = NSDictionary()
    
    override init() {
        super.init()
        loadFakeMessages()
        
        //avator
//        let avator = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("avator", backgroundColor: UIColor.init(white: 0.85, alpha: 1.0),
//                                                                               textColor: UIColor.init(white: 0.60, alpha: 1.0), font: UIFont.systemFontOfSize(14), diameter: kJSQMessagesCollectionViewAvatarSizeDefault)
        let avator = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "avatar"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        self.avatars = [AAMessageDataModel.kJSQDemoAvatarDisplayNameSquires: avator]
        
        self.users = [AAMessageDataModel.kJSQDemoAvatarIdSquires: AAMessageDataModel.kJSQDemoAvatarDisplayNameSquires]
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        self.outgoingBubbleImageData = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        self.incomingBubbleImageData = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
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