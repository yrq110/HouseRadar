//
//  FeedBackView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/21.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface FeedBackView : UIView<MFMailComposeViewControllerDelegate>
@property(strong,nonatomic)UILabel *label;
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UIButton *button;
@end
