//
//  MANameViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/6.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MANameViewController.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"judge.data"]

@interface MANameViewController ()

@property(nonatomic ,strong) UITextField *textField;

@end

@implementation MANameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.textField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 74, [UIScreen mainScreen].bounds.size.width-40, 40)];
        _textField = textField;
        textField.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:textField];
    }
    self.textField.text = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getTextData) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    
}

-(void)getTextData{
    
    NSString *name = self.textField.text;
    
    [NSKeyedArchiver archiveRootObject:name toFile:CZAccountFileName];
}

@end
