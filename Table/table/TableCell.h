//
//  TableCellTableViewCell.h
//  Table
//
//  Created by edutech on 15-4-18.
//  Copyright (c) 2015年 edutech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
{
    NSMutableArray *cellDatas;
    NSMutableArray *widthArray;
    int cellHeight;
    int totalWidth;
}

-(id)initTableCell:(NSMutableArray*) cellsData widths:(NSMutableArray *)widths height:(int)height Identifier:(NSString*) identify Type:(int)type;

-(void)addCellDatas:(NSDictionary*) datas Index:(int)index;
@end
