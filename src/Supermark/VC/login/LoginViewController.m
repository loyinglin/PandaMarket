//
//  LoginViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LoginViewController.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYUITipsView.h"
#import "AllModel.h"
#import "AllMessage.h"
#import "LYTicker.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self lyObserveNotification:NOTIFY_LOGIN_SUCCESS];
    [self lyObserveNotification:NOTIFY_LOGIN_FAIL];
    
    [self lyObserveNotification:[ServerGetPhoneCodeEvent notifyName]];
    [self lyObserveEvent:[DataDateModelEvent instance]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
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
    [self.phone becomeFirstResponder];
}

#pragma mark - ui

-(void)clickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        LYLog(@"cancel login");
    }];
}

-(void)clickSave:(id)sender
{
    if (self.phone.text.length == 11) {
        
        [[LoginMessage instance] requestLoginWithPhone:self.phone.text Code:[self.code.text integerValue] ];
    }
    else{
        [self presentMessageTips:@"请输入正确的手机号码"];
    }
}

-(void)clickGetCode:(id)sender
{
    if ([[DateModel instance] getNotifyCodeTime] > 0) {
        return ;
    }
    else if (self.phone.text.length == 11) {
        [[LoginMessage instance] requestGetPhoneCode:self.phone.text];
        [[DateModel instance] setNotifyCodeTime:90];
    }
    else{
        [self presentMessageTips:@"请输入正确的手机号码"];
    }
}
#pragma mark - delegate
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
}


- (void)showAlert
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"登陆失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phone) {
        [self.phone resignFirstResponder];
        [self.code becomeFirstResponder];
    }
    else if(textField == self.code){
        [self.code resignFirstResponder];
        [self clickSave:textField];
    }
    return YES;
}


#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_LOGIN_FAIL]) {
        [self showAlert];
    }
    else if ([notify.name isEqualToString:NOTIFY_LOGIN_SUCCESS]){
        [self dismissViewControllerAnimated:YES completion:^{
//            LYLog(@"login success");
        }];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[ServerGetPhoneCodeEvent class]]) {
        [self presentMessageTips:@"获取验证码成功"];
    }
    if ([event isKindOfClass:[DataDateModelEvent class]]) {
        DataDateModelEvent* date = (DataDateModelEvent*)event;
        if (date.time) {
            [self.get_code setTitle:[NSString stringWithFormat:@"等待%lds", date.time]  forState:UIControlStateNormal];
        }
        else{
            [self.get_code setTitle:@"验证码" forState:UIControlStateNormal];
        }
    }
}

@end
