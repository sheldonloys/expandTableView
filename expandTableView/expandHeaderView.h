//
//  expandHeaderCell.h
//  expandTableView
//
//  Created by sheldonloys on 15/7/17.
//  Copyright (c) 2015年 sheldonloys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface expandHeaderView : UITableViewHeaderFooterView

@property (nonatomic, retain) UIButton *_headerBtn;
@property (nonatomic, retain) UIImageView *_arrow;

- (void)normalAnimation;
- (void)selectedAnimation;
@end
