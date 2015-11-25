//  Custom MultiSelect
//  XMMultiSelectView.h
//  XMMultiSelect
//
//  Created by Amon on 15/8/11.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMultiSelectView : UIView


//  The index of selected result
@property  NSInteger selectedIndex;

//  Selected result
@property (nonatomic, strong) NSString *selectedResult;

/**
 *  Init view with parameters
 *
 *  @param frame      View frame
 *  @param itemsCount Count of select items
 *  @param itemHeight Height of select items
 *  @param titleList  Title of select items
 *
 *  @return Current View
 */
-(id)initWithAllParameters:(CGRect)frame itemsCount:(NSInteger)itemsCount itemHeight:(CGFloat)itemHeight
                 titleList:(NSMutableArray *)titleList;

/**
 *  Select someone item
 *
 *  @param theIndex Select index
 */
- (void)changeSelectedIndex:(NSInteger)theIndex;


@end
