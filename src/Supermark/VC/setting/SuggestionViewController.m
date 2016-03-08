//
//  SuggestionViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/9/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SuggestionViewController.h"
#import "AllMessage.h"
#import "NSObject+LYUITipsView.h"

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 5);
    
    [self lyObserveEvent:[ServerAddFeedbackEvent instance]];
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

#pragma mark - ui
-(IBAction)clickSave:(id)sender
{
//    UIMessageConfirmEvent* event = [[UIMessageConfirmEvent alloc] init];
//    event.message = self.textView.text;
//    [self lyPostEvent:event];
    

    NSString* msg = self.textView.text;
    if (!msg || msg.length != 0) {
        [[FeedbackMessage instance] requestAddFeedback:msg];
    }
    else{
        [self presentMessageTips:@"意见不能为空"];
    }
}

#pragma mark - delegate

static NSString* msg = @"请留下您的任何意见或建议，我们会努力改进。";

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

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[ServerAddFeedbackEvent class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
