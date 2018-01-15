//
//  ViewController.m
//  GPCoverDemo
//
//  Created by chen on 2016/10/2.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//

#import "ViewController.h"
#import "GPCover.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView         *tableView;
@property(nonatomic, strong)NSArray             *titleArray;

@property (nonatomic, weak) GPCover             *cover;// 自定义遮罩
@property (nonatomic, weak) UIView              *customView;// 弹出的视图

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"半透明遮罩-中间弹窗",@"全透明遮罩-底部弹窗",@"自定义半透明遮罩",@"半透明弹窗-block",@"半透明遮罩-顶部弹窗",@"中部弹出-底部消失"];
    self.title = @"GPCoverDemo";
    
    [self loadTableView];
    
}
#pragma mark -
#pragma mark -- TableViewDelegate
-(void)loadTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOUNDS_WIDTH, BOUNDS_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndertifier=@"cellIndertifier";
    UITableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:cellIndertifier];
    if (!tableViewCell) {
        tableViewCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifier];
    }
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableViewCell.textLabel.text = _titleArray[indexPath.row];
    tableViewCell.textLabel.textAlignment = NSTextAlignmentCenter;
    tableViewCell.textLabel.font = [UIFont fontWithName:@"heiti SC" size:15.0];
    tableViewCell.textLabel.textColor = [UIColor blueColor];
    return tableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击了第 %ld 个单元格",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
            [self translucentCover];// 半透明遮罩-中间弹窗
            break;
        case 1:
            [self transparentCover];// 全透明遮罩-底部弹窗
            break;
        case 2:
            [self customTranslucentCover];// 自定义半透明遮罩
            break;
        case 3:
            [self coverWithBlock];// 半透明弹窗-block
            break;
        case 4:
            [self coverFromTop];// 半透明弹窗-顶部弹窗
            break;
        case 5:
            [self addCoverWithShowAndHideAnimation];// 中部弹出-底部消失
            break;
            
        default:
            break;
    }
}

-(void)translucentCover{
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor yellowColor];
    redView.size = CGSizeMake(150, 150);
    
    [GPCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:redView style:GPCoverStyleTranslucent showStyle:GPCoverShowStyleCenter animStyle:GPCoverAnimStyleCenter notClick:NO];
    
    if ([GPCover hasCover]) {
        NSLog(@"遮罩已存在");
    }else{
        NSLog(@"遮罩不存在");
    }
}

-(void)transparentCover{
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.size = CGSizeMake(self.view.frame.size.width, 200);
    
    [GPCover coverFrom:self.view contentView:blueView style:GPCoverStyleTransparent showStyle:GPCoverShowStyleBottom animStyle:GPCoverAnimStyleBottom notClick:NO];
}

- (void)customTranslucentCover{
    GPCover *cover = [GPCover translucentCoverWithTarget:self action:@selector(hiddenCover)];
    cover.alpha = 0.5;
    cover.frame = self.view.bounds;
    [self.navigationController.view addSubview:cover];
    self.cover = cover;
    
    UIView *customView = [UIView new];
    customView.backgroundColor = [UIColor yellowColor];
    customView.frame = CGRectMake(0, KScreenH, KScreenW, 200);
    [self.navigationController.view addSubview:customView];
    self.customView = customView;
    
    [UIView animateWithDuration:0.25 animations:^{
        customView.y = KScreenH - 200;
    }];
}

- (void)hiddenCover{
    [UIView animateWithDuration:0.25 animations:^{
        self.customView.y = KScreenH;
    }completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        [self.customView removeFromSuperview];
        [GPCover hide];
    }];
}

// 半透明弹窗-block
- (void)coverWithBlock{
    UIView *customView = [UIView new];
    customView.size = CGSizeMake(KScreenW, 200);
    customView.backgroundColor = [UIColor greenColor];
    
    [GPCover translucentCoverFrom:self.view content:customView animated:YES showBlock:^{
        // 显示出来时的block
        NSLog(@"弹窗显示了，6不6");
    } hideBlock:^{
        // 移除后的block
        NSLog(@"弹窗消失了，555");
    }];
}

// 半透明弹窗-顶部弹窗 中间弹窗 底部弹窗
- (void)coverFromTop{
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor yellowColor];
    redView.size = CGSizeMake(KScreenW, 200);
    
    __block UIView *view = [UIView new];
    view.frame = CGRectMake(0, 64, KScreenW, KScreenH - 64);
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    [GPCover coverFrom:view contentView:redView style:GPCoverStyleTranslucent showStyle:GPCoverShowStyleTop animStyle:GPCoverAnimStyleTop notClick:NO showBlock:^{
        NSLog(@"遮罩显示了");
    } hideBlock:^{
        NSLog(@"遮罩隐藏了");
        [view removeFromSuperview];
        view = nil;
    }];
}

//增加隐藏动画  中部弹出-底部消失
-(void)addCoverWithShowAndHideAnimation{
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor yellowColor];
    redView.size = CGSizeMake(200, 200);
    
    //    [GPCover coverHideStatusBarWithContentView:redView style:GPCoverStyleTranslucent showStyle:GPCoverShowStyleCenter showAnimStyle:GPCoverShowAnimStyleCenter hideAnimStyle:GPCoverHideAnimStyleBottom notClick:NO showBlock:nil hideBlock:nil];
    
    [GPCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:redView style:GPCoverStyleTranslucent showStyle:GPCoverShowStyleCenter showAnimStyle:GPCoverShowAnimStyleCenter hideAnimStyle:GPCoverHideAnimStyleBottom notClick:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

