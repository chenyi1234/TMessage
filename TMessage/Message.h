//
//  Message.h
//  TMessage
//
//  Created by tarena on 16/1/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic,strong)NSString *content;
@property(nonatomic,getter=isFromMe)BOOL fromMe;

+(NSArray *)demoData;

@end






