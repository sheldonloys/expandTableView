//
//  expandHeaderCell.m
//  expandTableView
//
//  Created by sheldonloys on 15/7/17.
//  Copyright (c) 2015年 sheldonloys. All rights reserved.
//

#import "expandHeaderView.h"

#define screenWidth [[UIScreen mainScreen] bounds].size.width

@implementation expandHeaderView
@synthesize _headerBtn;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _headerBtn.frame = CGRectMake(0, 0, screenWidth, 50);
        [_headerBtn.layer setBorderWidth:.5];
        [_headerBtn setTitle:@"expand me!" forState:UIControlStateNormal];
        [self.contentView addSubview:_headerBtn];
    }
    return self;
}

@end
