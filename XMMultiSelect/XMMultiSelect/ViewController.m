//
//  ViewController.m
//  XMMultiSelect
//
//  Created by Amon on 15/8/11.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "ViewController.h"
#import "XMMultiSelectView.h"

#define TAG_SELECT_VIEW_COUNTRY 1024
#define TAG_SELECT_VIEW_SKIN 1025

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    CGFloat startX = 20;
    CGFloat startY = 100;
    CGFloat commonWidth = self.view.frame.size.width - startX * 2;
    CGFloat commonHeight = 40;
    CGFloat commonVerticalMargin = 20;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleName = [infoDictionary objectForKey:@"CFBundleName"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, 40, commonWidth, commonHeight)];
    titleLabel.text = bundleName;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    //  Select items title. First object is the head title.
    NSMutableArray *countryTitleList = [NSMutableArray arrayWithArray:@[ @"Country", @"China", @"England", @"France" ]];
    XMMultiSelectView *countrySelectView = [[XMMultiSelectView alloc]
                                     initWithAllParameters:CGRectMake(startX, startY, commonWidth, commonHeight*countryTitleList.count)
                                        itemsCount:countryTitleList.count
                                     itemHeight:commonHeight
                                     titleList:countryTitleList];
    [self.view addSubview:countrySelectView];
    
    NSMutableArray *skinTitleList = [NSMutableArray arrayWithArray:@[ @"Skin", @"White", @"Yellow", @"Black" ]];
    XMMultiSelectView *skinSelectView = [[XMMultiSelectView alloc]
                                     initWithAllParameters:CGRectMake(startX, countrySelectView.frame.origin.y + countrySelectView.frame.size.height + commonVerticalMargin, commonWidth, commonHeight*skinTitleList.count)
                                     itemsCount:skinTitleList.count
                                     itemHeight:commonHeight
                                     titleList:skinTitleList];
    [self.view addSubview:skinSelectView];
    
    countrySelectView.tag = TAG_SELECT_VIEW_COUNTRY;
    skinSelectView.tag = TAG_SELECT_VIEW_SKIN;
    
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, commonWidth, commonHeight)];
    actionButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 60);
    [actionButton setTitle:@"OK" forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    actionButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    actionButton.layer.borderWidth = .5;
    actionButton.layer.cornerRadius = 5;
    [actionButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionButton];
}

- (void)done
{
    //  Get select index.
    NSInteger indexOfCountry = ((XMMultiSelectView *)[self.view viewWithTag:TAG_SELECT_VIEW_COUNTRY]).selectedIndex;
    NSInteger indexOfSkin = ((XMMultiSelectView *)[self.view viewWithTag:TAG_SELECT_VIEW_SKIN]).selectedIndex;
    NSLog(@"Country Index is %ld, Skin Index is %ld", indexOfCountry, indexOfSkin);
    
    //  Get select result.
    NSString *resultOfCountry = ((XMMultiSelectView *)[self.view viewWithTag:TAG_SELECT_VIEW_COUNTRY]).selectedResult;
    NSString *resultOfSkin = ((XMMultiSelectView *)[self.view viewWithTag:TAG_SELECT_VIEW_SKIN]).selectedResult;
    
    //  Show the select result.
    NSString *showMessage = [NSString stringWithFormat:@"Your select is %@, %@", resultOfCountry, resultOfSkin];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:showMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
   [alert addAction:okAction];
                               
    [self presentViewController:alert animated:YES completion:nil];
}


@end
