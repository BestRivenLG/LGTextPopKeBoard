//
//  ViewController.m
//  文本自定义弹出视图
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 ZnLG. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIView+LCCategory.h"

@interface ViewController ()<UITextFieldDelegate>//,UITextViewDelegate>
@property (strong, nonatomic)  UITextField *textField;
//@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (strong, nonatomic)NSLayoutConstraint *textFieldTop;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldBottom;
@property (strong,nonatomic) MASConstraint *textFieldTop;
@property (strong,nonatomic) MASConstraint *textFieldBottom;
@property (assign,nonatomic) CGFloat textFieldY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor yellowColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    self.textFieldY = self.view.height - 30;
    textField.frame = CGRectMake(0, self.textFieldY, self.view.width, 30);
    
    [self.view addSubview:textField];
    self.textField = textField;
    
    
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
////        make.top.equalTo(self.view);
////        make.bottom.equalTo(self.view);
//        make.height.equalTo(@30);
//        self.textFieldBottom = make.bottom.equalTo(self.view);
//    }];
    
//    self.textFieldTop.constant = self.textField.frame.origin.y;

     [self keyboardview];
    
    
}

#pragma mark - 键盘上的view
- (void)keyboardview {
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    inputView.backgroundColor = [UIColor whiteColor];
    
//    self.textField.inputView = inputView;
//    self.textView.inputView = inputView;
    self.textField.inputAccessoryView = inputView;
//    self.textView.inputAccessoryView = inputView;
    
}

- (void)keyboardShowNotification:(NSNotification*)note
{
    double duration = [[note.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"]doubleValue];
    NSValue *keyboardValue = [note.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyboardRect = [keyboardValue CGRectValue];
    CGFloat keyboardHeight = self.view.height - keyboardRect.origin.y ;
//    self.textFieldBottom.offset = -keyboardHeight;
//    self.textFieldBottom.constant = -keyboardHeight;
    self.textField.y = self.textFieldY - keyboardHeight;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
