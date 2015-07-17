//
//  ViewController.m
//  expandTableView
//
//  Created by sheldonloys on 15/7/17.
//  Copyright (c) 2015年 sheldonloys. All rights reserved.
//

//屏幕宽度
#define screenWidth [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"
#import "expandHeaderView.h"

@interface ViewController ()
{
    NSArray * _testDatas;
    NSMutableArray * _expands;
    UITableView * _contentTableView;
    BOOL _compeleteAnimation;
    NSInteger _animationNum;
}
@end

@implementation ViewController

#pragma mark - override Method

- (void)viewDidLoad {
    
    [self initEverything];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initViewAndData

- (void)initEverything {
    
    _compeleteAnimation = YES;
    _testDatas = @[@"2",@"3",@"5",@"3",@"2",@"3",@"5",@"2",@"3",@"5",@"3",@"2",@"3",@"5"];
    _expands = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
    //关闭滚动view的上下留白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //整个view的滚动TableView容器
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _contentTableView.bounces = NO;
    [self.view addSubview: _contentTableView];
}

#pragma mark UITableView Delegate&Datasource

//expandHeader --展开头部
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_testDatas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *simpleTableIdentifier = @"expandHeader";
    
    expandHeaderView *expandHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:simpleTableIdentifier];
    
    if(expandHeader == nil)
    {
        expandHeader = [[expandHeaderView alloc] initWithReuseIdentifier:simpleTableIdentifier];

    }
    
    [expandHeader._headerBtn addTarget:self action:@selector(expandCell:) forControlEvents:UIControlEventTouchUpInside];
    if ([[_expands objectAtIndex:section] integerValue]==1)
        [expandHeader._headerBtn setBackgroundColor:[UIColor lightGrayColor]];
        else
            [expandHeader._headerBtn setBackgroundColor:[UIColor whiteColor]];

    expandHeader._headerBtn.tag = section;

    return expandHeader;
}

//expandContent --展开内容
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_testDatas objectAtIndex:section] integerValue]*[[_expands objectAtIndex:section] integerValue];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90; //展开的时候内容cell的高度
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *simpleTableIdentifier = @"expandContent";
    UITableViewCell *expandContent = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (expandContent == nil) {
        expandContent = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    expandContent.textLabel.text = @"Lisa!";

    return expandContent;
    
}

#pragma mark - Click To Expand

-(void)expandCell:(UIButton *)sender{

    if (!_compeleteAnimation ) {
        return;
    }
    
    NSInteger section = sender.tag;
    NSInteger thisSectionCanExpand = ![[_expands objectAtIndex:section] integerValue];
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    _animationNum = [[_testDatas objectAtIndex:section] integerValue];

    for (NSInteger i = 0; i != [[_testDatas objectAtIndex:section] integerValue]; ++ i) {
        
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:i inSection:section];
        [insertIndexPaths addObject:newPath];
    }
    
    if (thisSectionCanExpand) //展开列表
    {
        [sender setBackgroundColor:[UIColor lightGrayColor]];
        [_expands replaceObjectAtIndex:section withObject:@"1"];
        _compeleteAnimation = NO;
        [_contentTableView beginUpdates];
        [_contentTableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        [_contentTableView endUpdates];
        _compeleteAnimation = YES;
    }
    else
    {
        [_expands replaceObjectAtIndex:section withObject:@"0"];
        _compeleteAnimation = NO;
        [_contentTableView beginUpdates];
        [_contentTableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        [_contentTableView endUpdates];
        _compeleteAnimation = YES;
    }
}


@end
