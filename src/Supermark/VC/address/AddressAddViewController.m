//
//  AddressAddViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AddressAddViewController.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYUITipsView.h"
#import "AddressModel.h"
#import "ShopModel.h"
#import "AllMessage.h"

@interface AddressAddViewController ()

@end

@implementation AddressAddViewController
{
    NSString* tmpPhone;
    NSString* tmpAddress;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    LYLog(@"%@", self.navigationItem.rightBarButtonItem);
    
    [self lyObserveNotification:NOTIFY_ADDRESS_SAVE_BACK];
    
    [self lyObserveNotification:NOTIFY_ADDRESS_REMOVE_BACK];
    
    [self lyObserveNotification:NOTIFY_ADDRESS_ADD_BACK];
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


#pragma mark - view init

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.address_id == 0) { //add new address
        self.phone.text = @"";
        self.addr.text = @"";
        self.area.text = [[RecentShopModel instance] getCurrentAreaName];
        for (NSLayoutConstraint* item in self.area.constraints) {
            if ([item.identifier isEqualToString:@"height"]) {
                item.constant = 30;
            }
        }
    }
    else
    {
        for (NSLayoutConstraint* item in self.area.constraints) {
            if ([item.identifier isEqualToString:@"height"]) {
                item.constant = 0;
            }
        }
        Address* address = [[AddressModel instance] getAddressById:self.address_id];
        self.phone.text = address.phone;
        self.addr.text = address.address;
    }
    
    if (tmpPhone) { //此处用在保存地址时seesion过期，登陆回来的界面用
        self.phone.text = tmpPhone;
        self.addr.text = tmpAddress;
    }
    [self.phone becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    tmpPhone = self.phone.text;
    tmpAddress = self.addr.text;
}

#pragma mark - ui

-(IBAction)clickSave:(id)sender
{
    if (!self.phone.text || self.phone.text.length != 11) {
        
        [self presentMessageTips:@"手机号码格式错误"];
        return ;
    }
    if (!self.addr.text || [self.addr.text isEqualToString:@""]) {
        
        [self presentMessageTips:@"地址错误"];
        return ;
    }
    if (self.address_id) {
        [[AddressMessage instance] requestSaveAddressWithPhone:self.phone.text
                                                       Address:self.addr.text
                                                     AddressID:self.address_id];
    }
    else{
        [[AddressMessage instance] requestAddUserAddress:self.phone.text
                                                 Address:[NSString stringWithFormat:@"%@ %@", self.area.text, self.addr.text]];
    }
   }


-(IBAction)clickDelete:(id)sender
{
    [[AddressMessage instance] requestDelAddressWithId:self.address_id];
}

#pragma mark - delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phone) {
        [self.phone resignFirstResponder];
        [self.addr becomeFirstResponder];
    }
    else if (textField == self.addr){
        [self.addr resignFirstResponder];
        [self clickSave:textField];
    }
    return YES;
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//}
#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_ADDRESS_SAVE_BACK]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([notify.name isEqualToString:NOTIFY_ADDRESS_REMOVE_BACK]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([notify.name isEqualToString:NOTIFY_ADDRESS_ADD_BACK]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
