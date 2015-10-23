//
//  TableCellTableViewCell.m
//  Table
//
//  Created by edutech on 15-4-18.
//  Copyright (c) 2015年 edutech. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

-(id)initTableCell:(NSMutableArray *)cellsData widths:(NSMutableArray *)widths height:(int)height Identifier:(NSString *)identify Type:(int)type
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    if(self)
    {
        widthArray = widths;
        cellDatas = cellsData;
        cellHeight = height;
        int widthPosition = 0;
        for(int i=0;i<widthArray.count;i++)
        {
            int width = (int)[[widthArray objectAtIndex:i] integerValue];
            UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition,  cellHeight-1, width, 1)];
            line1.backgroundColor = [UIColor blackColor];
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition,  0, 1, cellHeight)];
            line2.backgroundColor = [UIColor blackColor];
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition, 0, width, cellHeight)];
            widthPosition += width;

            contentLabel.textColor = [UIColor grayColor];
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.font = [UIFont systemFontOfSize:12];
            contentLabel.tag = i+101;
            if(i==widthArray.count-1&&type==1)
            {
                UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(widthPosition-1,  0, 1, cellHeight)];
                line3.backgroundColor = [UIColor blackColor];
                [self addSubview:line3];
            }
            [self addSubview:line1];
            [self addSubview:line2];
            [self addSubview:contentLabel];
        }
        totalWidth = widthPosition;
        
    }
    return self;
}
-(void) addCellDatas:(NSDictionary *)datas Index:(int)index
{
    NSLog(@"index:%d",index);
    if(index==0)
    {
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, totalWidth, 1)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
    }
    for(int i=0;i<widthArray.count;i++)
    {
        UILabel *label = (UILabel*)[self viewWithTag:i+101];
        NSString *content = @"";
        
        if([datas objectForKey:[NSNumber numberWithInt:i]])
        {
            content = [datas objectForKey:[NSNumber numberWithInt:i]];
        }
        NSLog(@"content:%@",content);
        if(label)
        {
            label.text = content;
        }
    }
}
@end
