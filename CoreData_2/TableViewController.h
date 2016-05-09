//
//  TableViewController.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Item;

@interface TableViewController : UITableViewController

@property (nonatomic, strong) Item *parent;

@end
