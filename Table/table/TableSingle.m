//
//  TableSingle.m
//  Table
//
//  Created by edutech on 15-4-18.
//  Copyright (c) 2015年 edutech. All rights reserved.
//

#import "TableSingle.h"

@implementation TableSingle
{
    int widthNumber;
    int leftTotalWidth;
    int rightTotalWidth;
}

-(id)initTable:(NSMutableArray *)widths Names:(NSMutableArray *)names Datas:(NSMutableArray *)datas Height:(float)height Rect:(CGRect)rect Left:(int)number LeftDatas:(NSMutableArray *)leftdatas
{
    self = [super init];
    if(self)
    {
        leftNumber = number;
        [self initTableDatas:widths Name:names Datas:datas];
        tableHeight = height;
        self.frame = rect;
        widthNumber = (int)widths.count;
        leftTotalWidth = 0;
        rightTotalWidth = 0;
        leftDatas = leftdatas;
        cellDatas = datas;
        for(int i=0;i<leftNumber;i++)
        {
            leftTotalWidth += [[widths objectAtIndex:i] integerValue];
        }
        for(int i=leftNumber;i<widthNumber;i++)
        {
            rightTotalWidth += [[widths objectAtIndex:i] integerValue];
        }
        [self initTable];
    }
    
    return self;
}
-(void) initTableDatas:(NSMutableArray*)widths Name:(NSMutableArray *)names Datas:(NSMutableArray *)datas
{
    if(leftNumber<=0)
    {
        simpleWidths = widths;
        simpleNames = names;
        cellDatas = datas;
        leftWidths = [[NSMutableArray alloc] init];
        leftNames = [[NSMutableArray alloc] init];
    }else
    {
        simpleWidths = [self subArray:widths StartIndex:leftNumber EndIndex:(int)widths.count];
        simpleNames = [self subArray:names StartIndex:leftNumber EndIndex:(int)widths.count];;
        leftWidths = [self subArray:widths StartIndex:0 EndIndex:leftNumber];
        leftNames = [self subArray:names StartIndex:0 EndIndex:leftNumber];
    }
}
-(NSMutableArray*) subArray:(NSMutableArray*) array StartIndex:(int)start EndIndex:(int)end
{
    if(array.count<start||array.count<end||start<0||end<0)
    {
        return array;
    }
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for(int i=start;i<end;i++)
    {
        [newArray addObject:[array objectAtIndex:i]];
    }
    return newArray;
}
-(void) initTable
{
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.frame = CGRectMake(0, 0, leftTotalWidth, self.frame.size.height);
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.singleTable = [[UITableView alloc] init];
    self.singleTable.frame = CGRectMake(0, 0, rightTotalWidth, self.frame.size.height);
    self.singleTable.dataSource = self;
    self.singleTable.delegate = self;
    self.singleTable.backgroundColor = [UIColor whiteColor];
    self.singleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(leftTotalWidth, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(rightTotalWidth+leftTotalWidth, self.frame.size.height);
    self.scrollView.bounces = NO;
    [self.scrollView addSubview:self.singleTable];
//    [self.scrollView addSubview:self.leftTableView];
    [self addSubview:self.scrollView];
    [self addSubview:self.leftTableView];
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(leftTotalWidth, 0, rightTotalWidth, tableHeight)];
    int widthPosition = 0;
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, rightTotalWidth, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [self.headerView addSubview:line1];
    for(int i=0;i<simpleWidths.count;i++)
    {
        int width = (int)[[simpleWidths objectAtIndex:i] integerValue];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition, 0, width, tableHeight)];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition,  0, 1, tableHeight)];
        line2.backgroundColor = [UIColor blackColor];
        label.text = [simpleNames objectAtIndex:i] ;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        widthPosition += width;
        if(i==(simpleWidths.count-1))
        {
            UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition-1,  0, 1, tableHeight)];
            line3.backgroundColor = [UIColor blackColor];
            [self.headerView addSubview:line3];
            NSLog(@"line3_head");
        }
        
        [self.headerView addSubview:label];
        [self.headerView addSubview:line2];
    }
    self.leftHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftTotalWidth, tableHeight)];
    int leftwidthPosition = 0;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, leftTotalWidth, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.leftHeaderView addSubview:line];
    for(int i=0;i<leftWidths.count;i++)
    {
        int width = (int)[[leftWidths objectAtIndex:i] integerValue];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftwidthPosition, 0, width, tableHeight)];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(leftwidthPosition,  0, 1, tableHeight)];
        line2.backgroundColor = [UIColor blackColor];
        label.text = [leftNames objectAtIndex:i] ;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        leftwidthPosition += width;
        [self.leftHeaderView addSubview:label];
        [self.leftHeaderView addSubview:line2];
    }
    self.leftHeaderView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.singleTable)
    {
        static NSString *identifier = @"singlecell";
        TableCell *myCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(self.myCell==nil)
        {
            myCell = [[TableCell alloc] initTableCell:cellDatas widths:simpleWidths height:tableHeight Identifier:identifier Type:1];
            myCell.backgroundColor = [UIColor whiteColor];
            myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *data = [cellDatas objectAtIndex:indexPath.row];
        [myCell addCellDatas:data Index:(int)indexPath.row];
        return myCell;
    }else if(tableView==self.leftTableView)
    {
        static NSString *identifier = @"leftcell";
        TableCell *myCell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(self.myCell==nil)
        {
            myCell2 = [[TableCell alloc] initTableCell:leftDatas widths:leftWidths height:tableHeight Identifier:identifier Type:0];
            myCell2.backgroundColor = [UIColor whiteColor];
            myCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *data = [leftDatas objectAtIndex:indexPath.row];
        [myCell2 addCellDatas:data Index:(int)indexPath.row];
        return myCell2;
    }
    return nil;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = self.singleTable.contentOffset.y;
    CGFloat x = self.singleTable.contentOffset.x;
    CGPoint point = self.leftTableView.contentOffset;
    CGPoint pointRight = self.singleTable.contentOffset;
    point.y = y;
    self.leftTableView.contentOffset = point;
    if(y==0)
    {
        self.leftTableView.contentOffset = CGPointZero;
    }
    if(x>leftTotalWidth)
    {
        pointRight.x = leftTotalWidth;
        self.singleTable.contentOffset = pointRight;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.singleTable)
    {
        return cellDatas.count;
    }else if(tableView==self.leftTableView)
    {
        return leftDatas.count;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView==self.singleTable)
    {
        return self.headerView;
    }else if(tableView==self.leftTableView)
    {
        return self.leftHeaderView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableHeight;
}
@end
