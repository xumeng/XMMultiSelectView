//
//  XMMultiSelectView.m
//  XMMultiSelect
//
//  Created by Amon on 15/8/11.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMMultiSelectView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation XMMultiSelectView

@synthesize selectedIndex;
@synthesize selectedResult;

-(id)initWithAllParameters:(CGRect)frame itemsCount:(NSInteger)itemsCount itemHeight:(CGFloat)itemHeight
                 titleList:(NSMutableArray *)titleList
{
    self = [self initWithFrame:frame];
    if (self) {
        [self initView:itemsCount itemHeight:itemHeight titleList:titleList];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initView:(NSInteger)itemsCount itemHeight:(CGFloat)itemHeight
       titleList:(NSMutableArray *)titleList
{
    CGFloat startX = 0;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, itemHeight)];
    titleLabel.text = [titleList objectAtIndex:0];
    titleLabel.textColor = UIColorFromRGB(0x535353);
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:titleLabel];
    
    CGFloat startY = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    for (int i=1; i<titleList.count; i++) {
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, self.frame.size.width-startX * 2, itemHeight)];
        [tempButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [tempButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 28, 0, 0)];
        [tempButton setTitle:[titleList objectAtIndex:i] forState:UIControlStateNormal];
        [tempButton setTitleColor:( (i == titleList.count - 1) ? UIColorFromRGB(0x535353) : UIColorFromRGB(0xcccccc)) forState:UIControlStateNormal];
        tempButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [tempButton setBackgroundColor:[UIColor whiteColor]];
        tempButton.tag = i;
        [tempButton addTarget:self action:@selector(gotoSelectItem:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == titleList.count - 1) {
            UIImageView *selImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tempButton.frame.size.width - 12*2 -30, 7, 26, 26)];
            selImageView.image = [UIImage imageNamed:@"check"];
            [tempButton addSubview:selImageView];
            
            selectedResult = titleList[i];
            selectedIndex = i-1;
        }
        
        if (i != titleList.count-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, itemHeight-1, tempButton.frame.size.width, 1)];
            lineView.backgroundColor = UIColorFromRGB(0xcccccc);
            [tempButton addSubview:lineView];
        }
        
        [self addSubview:tempButton];
        startY += itemHeight;
    }
    
}

- (void)gotoSelectItem:(UIButton *)sender
{
    [self changeSelectedIndex:sender.tag-1];
    selectedResult = sender.titleLabel.text;
}

- (void)changeSelectedIndex:(NSInteger)theIndex
{
    selectedIndex = theIndex;
    UIButton *otherButton;
    UIImageView *selImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-12 * 2-30, 7, 26, 26)];
    selImageView.image = [UIImage imageNamed:@"check"];
    
    for (UIView *tempView in self.subviews) {
        if ([tempView isKindOfClass:[UIButton class]] && theIndex != tempView.tag-1 ) {
            otherButton = (UIButton *)tempView;
            [otherButton setTitleColor:UIColorFromRGB(0xcccccc) forState:UIControlStateNormal];
            for (UIView *subTempView in otherButton.subviews) {
                if ([subTempView isKindOfClass:[UIImageView class]]) {
                    [subTempView removeFromSuperview];
                }
            }
            
        }else if([tempView isKindOfClass:[UIButton class]]){
            otherButton = (UIButton *)tempView;
            [otherButton setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
            [otherButton addSubview:selImageView];
        }
    }
}


@end
