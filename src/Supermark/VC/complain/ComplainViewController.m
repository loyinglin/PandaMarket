//
//  ComplainViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/9/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ComplainViewController.h"
#import "AllMessage.h"
#import "NSObject+LYUITipsView.h"
#import "LYColor.h"

@interface ComplainViewController ()

@end

static NSString* msg = @"请输入您对我们的建议（限300字）";

@implementation ComplainViewController
{
    long myOrderId;
    NSArray* myButtons;
    long selectId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myButtons = [NSArray arrayWithObjects:self.button0, self.button1, self.button2,
                 self.button3, self.button4, self.button5,
                 self.button6, self.button7, self.button8,
                 self.button9, self.button10, self.button11,
                 nil];
    [self selectButton:self.button0];
    self.suggestion.layer.borderWidth = 1;
    self.suggestion.layer.borderColor = UIColorFromRGB(0xcdcdcd).CGColor;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userClickSuggestion:)];
    [self.toSuggest addGestureRecognizer:tap];
    
    [self lyObserveEvent:[ServerAddComplaintEvent instance]];
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
-(void)setOrderId:(long)orderId
{
    myOrderId = orderId;
}
#pragma mark - ui
-(void)selectButton:(UIButton*)button
{
    selectId = -1;
    for (int i = 0; i < myButtons.count; ++i) {
        UIButton* item = (UIButton*)myButtons[i];
        if (item) {
            item.layer.borderColor = UIColorFromRGB(0xcdcdcd).CGColor;
            item.layer.borderWidth = 1;
            item.layer.cornerRadius = 3;
            item.backgroundColor = [UIColor whiteColor];
            [item setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];

            if (item == button) {
                selectId = i;
                item.backgroundColor = UIColorFromRGB(LY_COLOR_RED);
                [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
}

-(IBAction)userClickSubmit:(id)sender
{
    LYLog(@"submit");
    UIButton* item = myButtons[selectId];
    if (item) {
        NSString* type = item.titleLabel.text;
        NSString* msg = self.suggestion.text;
        if (!msg || msg.length == 0) {
            msg = @" ";
        }

        [[OrderMessage instance] requestAddComplaint:myOrderId Type:type Msg:msg];

    }
}

-(IBAction)userClickButton:(UIButton*)sender
{
    [self selectButton:sender];
}

-(void)userClickSuggestion:(id)sender
{
    [self performSegueWithIdentifier:@"open_suggestion_from_complain" sender:self];
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
-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[ServerAddComplaintEvent class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
