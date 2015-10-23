//
//  ViewController.m
//  Table
//
//  Created by edutech on 15-4-18.
//  Copyright (c) 2015年 edutech. All rights reserved.
//

#import "ViewController.h"
#import "TableSingle.h"
@interface ViewController ()
{
    NSMutableArray *widthSize;
    NSMutableArray *headNames;
    NSMutableArray *tableDatas;
    NSMutableArray *leftDatas;
    int cellHeight;
    int leftNumber;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    leftNumber = 2;
    [self initTableDatas];
    TableSingle *tableview = [[TableSingle alloc] initTable:widthSize Names:headNames Datas:tableDatas Height:cellHeight Rect:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) Left:leftNumber LeftDatas:leftDatas];
    tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];
    
}

-(void) initTableDatas
{
    cellHeight = 40;
    widthSize = [[NSMutableArray alloc] init];
    [widthSize addObject:[NSNumber numberWithInt:60]];
    [widthSize addObject:[NSNumber numberWithInt:70]];
    [widthSize addObject:[NSNumber numberWithInt:60]];
    [widthSize addObject:[NSNumber numberWithInt:80]];
    [widthSize addObject:[NSNumber numberWithInt:50]];
    [widthSize addObject:[NSNumber numberWithInt:70]];
    [widthSize addObject:[NSNumber numberWithInt:70]];
    
    headNames = [[NSMutableArray alloc] init];
    [headNames addObject:@"序号"];
    [headNames addObject:@"收藏"];
    [headNames addObject:@"浏览"];
    [headNames addObject:@"未浏览"];
    [headNames addObject:@"详情"];
    [headNames addObject:@"已阅读"];
    [headNames addObject:@"未阅读"];
    
    tableDatas = [[NSMutableArray alloc] init];
    for(int i=0;i<28;i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        for(int j=0;j<(7-leftNumber);j++)
        {
            int number = arc4random()%100;
            [dic setObject:[NSString stringWithFormat:@"%d",number] forKey:[NSNumber numberWithInt:j]];
        }
        [tableDatas addObject:dic];
    }
    leftDatas = [[NSMutableArray alloc] init];
    for(int i=0;i<28;i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSString stringWithFormat:@"%d",(i+1)] forKey:[NSNumber numberWithInt:0]];
        for(int j=1;j<leftNumber;j++)
        {
            int number = arc4random()%100;
            [dic setObject:[NSString stringWithFormat:@"%d",number] forKey:[NSNumber numberWithInt:j]];
        }
        [leftDatas addObject:dic];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
