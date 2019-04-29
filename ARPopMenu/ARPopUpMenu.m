//
//  ARPopUpMenu.m
//
//  Created by Anshu on 03/05/18.
//  Copyright © 2018 Anshu. All rights reserved.
//

#import "ARPopUpMenu.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

ARPopMenuReturnBlock ARPopMenuBlock;
static ARPopUpMenu *shared = nil;

@implementation ARPopUpMenu

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
        tapRecognizer.cancelsTouchesInView = NO;
        tapRecognizer.delegate = self;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

+ (id)shared {
    if (!shared) {
        shared = [[ARPopUpMenu alloc] init];
    }
    return shared;
}

- (void)viewTapGesture:(UITapGestureRecognizer*)sender {
    for (UIView *v in shared.subviews) {
        [v removeFromSuperview];
    }
    [shared removeFromSuperview];
}

- (void)showMenuWithOption:(NSArray *)options origin:(CGPoint)origin images:(NSArray *)images backgroundColor:(UIColor *)bgColor textColor:(UIColor *)txtColor imageColor:(UIColor *)imgColor isMultiLineTitle:(BOOL)isMultiLineTitle isHaveSeparator:(BOOL)isHaveSeparator WithComptionBlock:(ARPopMenuReturnBlock)block {

    ARPopMenuBlock = [block copy];
    shared.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    shared.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-origin.x>=180?origin.x:SCREEN_WIDTH-180, origin.y, 170, options.count>6?300:options.count*55)];
   
    bgView.layer.borderWidth = 1;
    UITableView *tableView_menu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, bgView.bounds.size.height) style:UITableViewStylePlain];
    tableView_menu.showsHorizontalScrollIndicator = NO;
    tableView_menu.showsVerticalScrollIndicator = NO;
    tableView_menu.backgroundColor = bgColor;
    tableView_menu.dataSource = self;
    tableView_menu.delegate = self;
    if (options.count>6) {
        tableView_menu.scrollEnabled = YES;
    }else {
        tableView_menu.scrollEnabled = NO;
    }
    if (isHaveSeparator) {
        tableView_menu.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView_menu.separatorInset = UIEdgeInsetsZero;
        tableView_menu.separatorColor = [UIColor darkGrayColor];
    }else {
        tableView_menu.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    tableView_menu.tableFooterView = [UIView new];
    shared.isMultiLineTitle = isMultiLineTitle;
    if (isMultiLineTitle) {
        tableView_menu.estimatedRowHeight = 55;
        tableView_menu.rowHeight = UITableViewAutomaticDimension;
        tableView_menu.scrollEnabled = YES;
    }
    shared.bgColor = bgColor;
    shared.textColor = txtColor;
    shared.imgColor = imgColor;

    shared.imageArray = [NSArray arrayWithArray:images];
    shared.dataSourceArray = [NSArray arrayWithArray:options];
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bgView.backgroundColor = [UIColor clearColor];
    bgView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    bgView.layer.shadowOpacity = 0.6;
    bgView.layer.shadowRadius = 3.0;
    [bgView addSubview:tableView_menu];
    [shared addSubview:bgView];
    [tableView_menu reloadData];
    [bgView bringSubviewToFront:shared];    
    [appDelegate.window addSubview:shared];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (shared.isMultiLineTitle) {
        return UITableViewAutomaticDimension;
    }
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shared.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [shared.dataSourceArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = shared.textColor;
    if (shared.imageArray != nil) {
        if (shared.imageArray.count>0) {
            if (shared.imageArray.count-1>=indexPath.row) {
                UIImage *image = [[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                cell.imageView.image = image;
             }else {
             cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
        }else
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (shared.isMultiLineTitle) {
        cell.textLabel.numberOfLines = 0;
    }
    [cell.imageView setTintColor:shared.imgColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ARPopMenuBlock(indexPath.row);
    for (UIView *v in shared.subviews) {
        [v removeFromSuperview];
    }
    [shared removeFromSuperview];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

@end
