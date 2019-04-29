//
//  ARPopUpMenu.h
//
//  Created by Anshu on 03/05/18.
//  Copyright © 2018 Anshu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ARPopMenuReturnBlock)(NSInteger selectedIndex);

@interface ARPopUpMenu : UIView <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

+ (id)shared;

@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *bgColor;
@property (strong, nonatomic) UIColor *imgColor;
@property BOOL isMultiLineTitle;

- (void)showMenuWithOption:(NSArray *)options origin:(CGPoint)origin images:(NSArray *)images backgroundColor:(UIColor *)bgColor textColor:(UIColor *)txtColor imageColor:(UIColor *)imgColor isMultiLineTitle:(BOOL)isMultiLineTitle isHaveSeparator:(BOOL)isHaveSeparator WithComptionBlock:(ARPopMenuReturnBlock)block;

@end
