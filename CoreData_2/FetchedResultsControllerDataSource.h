//
//  FetchedResultsControllerDataSource.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSFetchedResultsController, UITableView;

@protocol FetchedResultsControllerDataSourceDelegate <NSObject>

- (void)configureCell:(id)cell withObject:(id)object; // 配置 cell
- (void)deleteObject:(id)object; // 删除 item

@end

@interface FetchedResultsControllerDataSource : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;
@property (nonatomic, weak) id<FetchedResultsControllerDataSourceDelegate> delegate;
/**
 *  cell 重用标识
 */
@property (nonatomic, copy)  NSString *reuseIdentifer;

/**
 *  暂停?
 */
@property (nonatomic, assign) BOOL paused;


- (instancetype)initWithTableView:(UITableView *)tableView;

- (id)selectedItem;


@end
