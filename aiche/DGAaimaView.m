//
//  DGAaimaView.m
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import "DGAaimaView.h"
#import "DGEarthView.h"

@interface DGAaimaView ()

@property (nonatomic, assign) CGFloat carX;
@property (nonatomic, assign) CGFloat changeCarX;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, strong) UILabel *textLable;

@property (nonatomic, strong) CADisplayLink *link;
@end



@implementation DGAaimaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self animaInit];
    }
    return self;
}
-(void)animaInit
{
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    self.backgroundColor = [UIColor blackColor];
   
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    _link = link;
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    DGEarthView * ainmeView =[[DGEarthView alloc]initWithFrame:self.bounds];
    [self addSubview:ainmeView];
    
    
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:jumpBtn];
    jumpBtn.frame = CGRectMake(windowSize.width-80, windowSize.height-20, 80, 20);
    [jumpBtn setTitle:@"跳过动画" forState:UIControlStateNormal];
    [jumpBtn setTintColor:[UIColor whiteColor]];
    [jumpBtn addTarget:self action:@selector(willJumpToMainView) forControlEvents:UIControlEventTouchUpInside];
    
    self.carX=[UIScreen mainScreen].bounds.size.width;
    self.changeCarX = 3;
    _i = 1;
}



- (void)drawRect:(CGRect)rect
{
    CGFloat maxX = [UIScreen mainScreen].bounds.size.width;
    NSArray *textArr = [[NSArray alloc] initWithObjects:
                        @"1769年，世界上第一辆蒸汽驱动的三轮汽车",
                        @"1885年10月,世界上第一辆发动机汽车",
                        @"1885年，世界上第一辆四轮汽车。",
                        @"1914年，亨利·福特将流水生产线技术运用到汽车上",
                        @"1937年，大众汽车公司成立，图为甲壳虫",
                        @"未来汽车是什么样子，让我们一起期待......",
                        @"未来超出我们的想象",nil];

    //car
   
    self.carX -= self.changeCarX;
    if (self.carX <=-150 ) {
        self.carX = maxX;
        _i++;
    }
    UIImage *imageBigYun = [UIImage imageNamed:[NSString stringWithFormat:@"car%ld",(long)_i]];
    NSString *text = textArr[_i-1];
    if (self.textLable==nil) {
        self.textLable = [[UILabel alloc]init];
        [self addSubview:self.textLable];
    }
    self.textLable.frame = CGRectMake((self.carX-self.changeCarX-25), 130, 200, 100);
    self.textLable.text = text;
    self.textLable.textColor= [UIColor whiteColor];
    self.textLable.numberOfLines = 0;

    
    [imageBigYun drawAtPoint:CGPointMake(self.carX,25 )];
    if (_i==7 && (self.carX+60==maxX/2||self.carX+61==maxX/2||self.carX+62==maxX/2)) {
        self.changeCarX = 0;
        [self willJumpToMainView];
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    

}
-(void)willJumpToMainView{
        
        if ([self.delegate respondsToSelector:@selector(stopAnimateViewWith:)]) {
            
            [self.delegate stopAnimateViewWith:self];
            
        }
}
@end
