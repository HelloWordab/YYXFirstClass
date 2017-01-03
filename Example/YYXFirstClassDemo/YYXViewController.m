//
//  YYXViewController.m
//  YYXFirstClassDemo
//
//  Created by yyx on 01/03/2017.
//  Copyright (c) 2017 yyx. All rights reserved.
//

#import "YYXViewController.h"
#import <YYXFirstClassDemo/UIImage+ImageEffects.h>

@interface YYXViewController ()

@end

@implementation YYXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = [imageView.image blurImage];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
