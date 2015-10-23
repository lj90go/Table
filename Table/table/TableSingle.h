//
//  TableSingle.h
//  Table
//
//  Created by edutech on 15-4-18.
//  Copyright (c) 2015年 edutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"
@interface TableSingle : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *simpleWidths;
    NSMutableArray *simpleNames;
    NSMutableArray *cellDatas;
    NSMutableArray *leftWidths;
    NSMutableArray *leftNames;
    NSMutableArray *leftDatas;
    float tableHeight;
    int leftNumber;
}

@property(nonatomic,retain) UITableView *singleTable;
@property(nonatomic,retain) TableCell *myCell;
@property(nonatomic,retain) UIView *headerView;
@property(nonatomic,retain) UIView *leftHeaderView;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UITableView *leftTableView;

-(id) initTable:(NSMutableArray *)widths Names:(NSMutableArray*) names Datas:(NSMutableArray*) datas Height:(float) height Rect:(CGRect)rect Left:(int)number LeftDatas:(NSMutableArray*)leftdatas;

@end
