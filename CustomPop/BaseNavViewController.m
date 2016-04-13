//
//  BaseNavViewController.m
//  CustomPop
//
//  Created by ZHOUPENGFEI on 16/4/9.
//  Copyright © 2016年 ZHOUPENGFEI. All rights reserved.
//

#import "BaseNavViewController.h"
#import <objc/runtime.h>
@interface BaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController


+(void)initialize{
    [[UINavigationBar appearance] setTintColor:[UIColor purpleColor]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    NSLog(@"%@",self.interactivePopGestureRecognizer);
//    unsigned int count = 0;
//    Ivar * ivars =   class_copyIvarList([UIGestureRecognizer class], &count);
//    for (int index = 0; index < count; index++) {
//        Ivar  iv = ivars[index];
//        NSString * ivarName =  @(ivar_getName(iv));
//        NSLog(@"%@",ivarName);
//    }
    self.interactivePopGestureRecognizer.enabled = NO;
    NSArray* targets = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    id objc = [targets firstObject];
    id target = [objc valueForKeyPath:@"_target"];
    
    UIPanGestureRecognizer * panGestrue = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    panGestrue.delegate = self;
    [self.view addGestureRecognizer:panGestrue];
    
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.topViewController == self.viewControllers.firstObject) {//处于当前的栈低
        return NO;
    }
    return YES;
}


@end
