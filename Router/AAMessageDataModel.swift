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
    
    static let kJSQDemoAvatarDisplayNameCook = "Tim Cook";
    static let kJSQDemoAvatarIdCook = "468-768355-23123";
    
    var messages = NSMutableArray()
    var avatars = NSDictionary()
    var outgoingBubbleImageData : JSQMessagesBubbleImage!
    var incomingBubbleImageData : JSQMessagesBubbleImage!
    var users = NSDictionary()
    
    init(fakeIndex: Int) {
        super.init()
        loadFakeMessages(fakeIndex)
        
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
    
    func loadFakeMessages(fakeIndex: Int) {
        
        let temp0 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdCook, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "WWDC Scholarships reward talented students and STEM organization members with the opportunity to attend this year’s conference. ")
        let temp1 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdCook, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "Developers selected for a scholarship will receive a WWDC 2016 ticket free of charge. ")
        let temp2 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdSquires, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: " In addition, travel assistance may be granted to scholarship recipients.")
        let temp3 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdSquires, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "To be eligible to apply for a WWDC Scholarship, you must be 13 years of age or older and a full or part-time student, or 13 years of age or older and a member/alumni of a STEM organization.")
        let temp4 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdSquires, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "Submit any app you have worked on that demonstrates creative use of Apple technologies and runs on an Apple platform. Your submission may be a school project, a project you've built on your own, or an app that is available on the App Store. ")
        let temp5 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdCook, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "You will also need to answer an essay question about your coding process and provide proof of enrollment from your school or proof of membership from your STEM organization.")
        let temp6 = JSQMessage(senderId: AAMessageDataModel.kJSQDemoAvatarIdCook, senderDisplayName: AAMessageDataModel.kJSQDemoAvatarDisplayNameCook, date: NSDate.distantPast(), text: "You can submit your scholarship application until Sunday, May 1 at 5:00 p.m. PDT. All applicants will be notified of their status by Monday, May 9.")
        
        var fakeMessages = [JSQMessage]()
        
        switch fakeIndex {
        case 0:
            fakeMessages.append(temp0)
            fakeMessages.append(temp6)
            fakeMessages.append(temp2)
            fakeMessages.append(temp1)
            fakeMessages.append(temp5)
            fakeMessages.append(temp3)
            fakeMessages.append(temp4)
            break
        case 1:
            fakeMessages.append(temp5)
            fakeMessages.append(temp6)
            fakeMessages.append(temp2)
            fakeMessages.append(temp1)
            fakeMessages.append(temp0)
            fakeMessages.append(temp4)
            fakeMessages.append(temp3)
            break
        case 2:
            fakeMessages.append(temp3)
            fakeMessages.append(temp6)
            fakeMessages.append(temp2)
            fakeMessages.append(temp1)
            fakeMessages.append(temp0)
            fakeMessages.append(temp4)
            fakeMessages.append(temp5)
            break
        case 3:
            fakeMessages.append(temp2)
            fakeMessages.append(temp0)
            fakeMessages.append(temp1)
            fakeMessages.append(temp5)
            fakeMessages.append(temp3)
            fakeMessages.append(temp4)
            break
        default:
            fakeMessages.append(temp6)
            fakeMessages.append(temp1)
            fakeMessages.append(temp2)
            fakeMessages.append(temp4)
            fakeMessages.append(temp5)
            fakeMessages.append(temp3)
            break
        }
        
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