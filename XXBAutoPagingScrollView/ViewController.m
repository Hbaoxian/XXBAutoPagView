//
//  ViewController.m
//  XXBAutoPagingScrollView
//
//  Created by 杨小兵 on 15/3/31.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBAutoPagView.h"
#import "XXBAutoPagViewCell.h"

@interface ViewController ()<XXBAutoPagViewDataSource , XXBAutoPagViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet XXBAutoPagView *autoPageView;
@property(nonatomic , strong)NSMutableArray *dataSourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.autoPageView.hidden = YES;
    [self setupAutoPageView];
    [self setButtons];

}
- (void)setButtons
{
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addbutton addTarget:self action:@selector(addbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbutton];
    addbutton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, 50, 50);
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    deleteButton.frame = CGRectMake(55, [UIScreen mainScreen].bounds.size.height - 50, 50, 50);
}
- (void)addbuttonClick
{
    if(self.dataSourceArray.count > 1)
    {
        [self.dataSourceArray insertObject:[NSString stringWithFormat:@"++ %@",@(self.dataSourceArray.count)] atIndex:1];
        [self.autoPageView addCellAtIndex:1];
    }
    else
    {
        [self.dataSourceArray insertObject:[NSString stringWithFormat:@"++ %@",@(self.dataSourceArray.count)] atIndex:0];
        [self.autoPageView addCellAtIndex:0];
    }
}
- (void)deleteButtonClick
{
    if (self.dataSourceArray.count >1)
    {
        [self.dataSourceArray removeObjectAtIndex:1];
        [self.autoPageView deleteCellAtIndex:1];
    }
}
- (void)setupAutoPageView
{
    XXBAutoPagView *autoPageView = [[XXBAutoPagView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:autoPageView];
    autoPageView.dataSource = self;
    autoPageView.delegate = self;
    autoPageView.pagingEnabled = YES;
    autoPageView.showsHorizontalScrollIndicator = NO;
    autoPageView.showsVerticalScrollIndicator = NO;
    autoPageView.verticalScroll = NO;
    _autoPageView = autoPageView;
}
- (void)autoPagView:(XXBAutoPagView *)autoPagView didSelectedCellAtIndex:(NSInteger)index
{
    NSLog(@"%@",@(index));
}
- (NSInteger)numberOfCellInAutoPagView:(XXBAutoPagView *)autoPagView
{
    return self.dataSourceArray.count;
}
- (XXBAutoPagViewCell *)autoPagViewCell:(XXBAutoPagView *)autoPagView cellAtIndex:(NSUInteger)index
{
    XXBAutoPagViewCell *autoCell = [[XXBAutoPagViewCell alloc] init];
    autoCell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:1.0];
    autoCell.title = [NSString stringWithFormat:@"第%@个cell",self.dataSourceArray[index]];
    return autoCell;
}
/**
 *  上下左右的边距
 *
 *  @param autoPagView autoPagView
 *  @param type        XXBAutoPagViewMarginType（边距类型上下左右）
 *
 *  @return 边距的大小
 */
- (CGFloat)autoPagView:(XXBAutoPagView *)autoPagView marginForType:(XXBAutoPagViewMarginType)type
{
    switch (type) {
        case XXBAutoPagViewMarginTypeTop:
        {
            return 40;
            break;
        }
        case XXBAutoPagViewMarginTypeBottom:
        {
            return 40;
            break;
        }
        case XXBAutoPagViewMarginTypeLeft:
        {
            return 30;
            break;
        }
        case XXBAutoPagViewMarginTypeRight:
        {
            return 30;
            break;
        }
        case XXBAutoPagViewMarginTypeColumn:
        {
            return 10;
            break;
        }
        case XXBAutoPagViewMarginTypeRow:
            
        {
            return 10;
            break;
        }
        default:
        {
            return 0;
            break;
        }
    }
    return 0;
}
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil)
    {
        _dataSourceArray = [NSMutableArray array];
        for(int  i = 0 ; i < 3 ; i++)
        {
           [_dataSourceArray addObject:@(i)];
        }
    }
    return _dataSourceArray;
}
@end
