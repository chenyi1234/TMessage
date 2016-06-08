//
//  MessageViewController.m
//  TMessage
//
//  Created by tarena on 16/1/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MessageViewController.h"
#import "Message.h"
#import "MessageCell.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;
//属性：记录全部的聊天内容
@property(nonatomic,strong)NSMutableArray *allMessages;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MessageViewController

- (NSMutableArray *)allMessages
{
    if (!_allMessages) {
        _allMessages = [[Message demoData] mutableCopy];
    }
    return _allMessages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //为了让tableView自适应高度，需要设置如下
    //两个属性
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //设置tableView的内边距，使得内容向下移动
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

//问1：
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//问2：
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMessages.count;
}

//问3:
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //找到此行的数据
    Message *message = self.allMessages[indexPath.row];
    
    //MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:message.isFromMe?@"MeCell":@"OtherCell" forIndexPath:indexPath];
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell" forIndexPath:indexPath];
    
    cell.message = message;
    
    return cell;
}



//弹起键盘时执行
-(void)openKeyboard:(NSNotification *)noti
{
    //读取键盘的高度
    CGFloat height = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //读取动画的种类
    NSInteger option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //读取动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //改约束
    self.inputViewBottomConstraint.constant = height;
    
    //做动画
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
        [self scrollToTableViewLastRow];
    } completion:nil];
    
}

//收起键盘时执行
-(void)closeKeyboard:(NSNotification *)noti
{
    //读取动画的种类
    NSInteger option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //读取动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //改约束
    self.inputViewBottomConstraint.constant = 0;
    
    //做动画
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}


//注册通知
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

//取消通知
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)sendMessage:(UITextField *)sender
{
    NSString *newContent = self.textField.text;
    if (newContent.length == 0) {
        return;
    }
    //根据输入的文字构建一个消息对象
    Message *newMessage = [Message new];
    newMessage.content = newContent;
    newMessage.fromMe = YES;
    
    //记录数据到allMessage中
    [self.allMessages addObject:newMessage];
    self.textField.text = @"";
    
    //针对新增加的数据，增加表格中的一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
}

//控制表视图滚动到最下面一行
-(void)scrollToTableViewLastRow
{
    //创建最后一行所在的indexPath
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.allMessages.count-1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollToTableViewLastRow];
}


@end
