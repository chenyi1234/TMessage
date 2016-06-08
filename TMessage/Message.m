//
//  Message.m
//  TMessage
//
//  Created by tarena on 16/1/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (NSArray *)demoData{
    Message *m1 = [[Message alloc]init];
    m1.content = @"你好！";
    m1.fromMe = YES;
    
    Message *m2 = [[Message alloc]init];
    m2.content = @"一点都不好";
    m2.fromMe = NO;
    
    Message *m3 = [[Message alloc]init];
    m3.content = @"最近在忙什么啊，有没有时间出来一起吃个饭啊，这么冷得天气适合吃点火锅啊，想想就觉得好香啊！";
    m3.fromMe = YES;
    
    Message *m4 = [[Message alloc]init];
    m4.content = @"最近胃口不是很好，很想吃点好吃的，不过火锅吃完有点上火啊换一个";
    m4.fromMe = NO;
    
    Message *m5 = [[Message alloc]init];
    m5.content = @"你还挺挑剔的，难你说吃点什么吧，听你的";
    m5.fromMe = YES;
    
    Message *m6 = [[Message alloc]init];
    m6.content = @"让我仔细的想一想吧";
    m6.fromMe = NO;
    
    Message *m7 = [[Message alloc]init];
    m7.content = @"我等。。。。。。我等。。。。。你怎么还没完没了了。。。。";
    m7.fromMe = YES;
    
    return @[m1,m2,m3,m4,m5,m6,m7];
}

@end







