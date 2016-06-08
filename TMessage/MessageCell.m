//
//  MessageCell.m
//  TMessage
//
//  Created by tarena on 16/1/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MessageCell
- (void)setMessage:(Message *)message{
    _message = message;
    self.contentLabel.text = message.content;
}




@end
