//
//  MessageViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/12.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "MessageViewController.h"
#import "NSObject+LYNotification.h"
#import "SettlementModel.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
    self.textView.text = [[SettlementModel instance] getMessage];
    if ([self.textView.text isEqualToString:@"null"]) {
        self.textView.text = msg;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - view init
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.textView setp
}

static NSString* msg = @"给商家留言";
#pragma mark - ui
-(void)clickSave:(id)sender
{
    UIMessageConfirmEvent* event = [[UIMessageConfirmEvent alloc] init];
    NSString* message = self.textView.text;
    event.message = message;
    [self lyPostEvent:event];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:msg]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
}




- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = msg;
    }
    [textView resignFirstResponder];
}
#pragma mark - notify


@end
