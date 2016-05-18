//
//  AAMessageViewController.swift
//  Router
//
//  Created by FOWAFOLO on 16/5/17.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import JSQMessagesViewController

protocol JSQDemoViewControllerDelegate {
    func didDismissJSQDemoViewController(vc: AAMessageViewController)
}

class AAMessageViewController: JSQMessagesViewController, UIActionSheetDelegate {
    
    var delegateModel: JSQDemoViewControllerDelegate?
    var displayName: String!
    var displaySenderId: String!
    var demoData: AAMessageDataModel!
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_messageStoryboard().instantiateViewControllerWithIdentifier(self.router_className()) as! AAMessageViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoData = AAMessageDataModel()
        displaySenderId = AAMessageDataModel.kJSQDemoAvatarIdSquires
        self.senderId = displaySenderId
        displayName = AAMessageDataModel.kJSQDemoAvatarDisplayNameSquires
        self.senderDisplayName = displayName
        self.title = "聊天"
        
        self.inputToolbar.contentView.textView.pasteDelegate = self
        
        
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        self.showLoadEarlierMessagesHeader = true
        JSQMessagesCollectionViewCell.registerMenuAction(#selector(AAMessageViewController.customAction))
        UIMenuController.sharedMenuController().menuItems = [UIMenuItem(title: "CustomAction", action: #selector(AAMessageViewController.customAction))]
        
        JSQMessagesCollectionViewCell.registerMenuAction(#selector(AAMessageViewController.deleteAction))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.delegateModel != nil {
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.collectionViewLayout.springinessEnabled = true
    }
    
    func customAction() {
        print("customAction")
    }
    
    func deleteAction() {
        print("deleteAction")
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        print("didPressSendButton")
        //TODO:
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        self.inputToolbar.contentView.textView.resignFirstResponder()
        let sheet = UIActionSheet(title: "Media messages", delegate: self,
                                  cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,
                                  otherButtonTitles: "Send Photo", "")
        sheet.showFromToolbar(self.inputToolbar)
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        //TODO:
        //        if (buttonIndex == actionSheet.cancelButtonIndex) {
        //            [self.inputToolbar.contentView.textView becomeFirstResponder];
        //            return;
        //        }
        //
        //        switch (buttonIndex) {
        //        case 0:
        //            [self.demoData addPhotoMediaMessage];
        //            break;
        //
        //        case 1:
        //            {
        //                __weak UICollectionView *weakView = self.collectionView;
        //
        //                [self.demoData addLocationMediaMessageCompletion:^{
        //                    [weakView reloadData];
        //                    }];
        //            }
        //            break;
        //
        //        case 2:
        //            [self.demoData addVideoMediaMessage];
        //            break;
        //
        //        case 3:
        //            [self.demoData addAudioMediaMessage];
        //            break;
        //        }
        //
        //        [JSQSystemSoundPlayer jsq_playMessageSentSound];
        //
        //        [self finishSendingMessageAnimated:YES];
    }
}

//MARK: - JSQMessagesCollectionViewDataSource
extension AAMessageViewController {
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.demoData.messages.objectAtIndex(indexPath.item) as! JSQMessageData
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.demoData.messages.objectAtIndex(indexPath.item) as! JSQMessage
        if message.senderId == self.senderId {
            return self.demoData.outgoingBubbleImageData
        }
        
        return self.demoData.incomingBubbleImageData
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.demoData.messages.removeObjectAtIndex(indexPath.item)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.demoData.messages.objectAtIndex(indexPath.item) as! JSQMessage
        if let item = self.demoData.avatars.objectForKey(message.senderId) as? JSQMessageAvatarImageDataSource{
            return item
        }
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        if indexPath.item % 3 == 0 {
            let message = self.demoData.messages.objectAtIndex(indexPath.item) as! JSQMessage
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
        }
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = self.demoData.messages.objectAtIndex(indexPath.item) as! JSQMessage
        if message.senderId == self.senderId {
            return nil
        }
        if indexPath.item - 1 > 0 {
            let previousMessage =  self.demoData.messages.objectAtIndex(indexPath.item - 1) as! JSQMessage
            if previousMessage.senderId == message.senderId {
                return nil
            }
        }
        
        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return demoData.messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(super.collectionView.numberOfSections())
        print(super.collectionView.numberOfItemsInSection(0))
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        let msg = self.demoData.messages.objectAtIndex(indexPath.item)
        
        if !msg.isMediaMessage() {
            if msg.senderId() == self.senderId {
                cell.textView.textColor = UIColor.blackColor()
            }else {
                cell.textView.textColor = UIColor.whiteColor()
            }
            
            cell.textView.linkTextAttributes = [NSForegroundColorAttributeName : cell.textView.textColor!]
            
            //            NSUnderlineStyle.StyleSingle , NSUnderlineStyle.PatternSolid]
            
        }
        
        return cell
    }
}

//MARK: - JSQMessagesCollectionViewDelegateFlowLayout
//extension AAMessageViewController: JSQMessagesCollectionViewDelegateFlowLayout {
//
//}

//MARK: -JSQMessagesComposerTextViewPasteDelegate
extension AAMessageViewController: JSQMessagesComposerTextViewPasteDelegate {
    func composerTextView(textView: JSQMessagesComposerTextView!, shouldPasteWithSender sender: AnyObject!) -> Bool {
        //TODO:
        //        if ([UIPasteboard generalPasteboard].image) {
        //            // If there's an image in the pasteboard, construct a media item with that image and `send` it.
        //            JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        //            JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
        //                senderDisplayName:self.senderDisplayName
        //                date:[NSDate date]
        //                media:item];
        //            [self.demoData.messages addObject:message];
        //            [self finishSendingMessage];
        //            return NO;
        //        }
        
        return true
    }
}