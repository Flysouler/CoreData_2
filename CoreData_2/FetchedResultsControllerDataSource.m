//
//  FetchedResultsControllerDataSource.m
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "FetchedResultsControllerDataSource.h"

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface FetchedResultsControllerDataSource () <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FetchedResultsControllerDataSource

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    return self;
}

#pragma mark -dataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> rows = self.fetchResultsController.sections[section];
    return rows.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.fetchResultsController objectAtIndexPath:indexPath];
    id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifer forIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(configureCell:withObject:)]) {
        [self.delegate configureCell:cell withObject:object];
    }
    
    return cell;
}

#pragma mark -可编辑的 cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.fetchResultsController objectAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.delegate deleteObject:object];
    }
}


#pragma mark -NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates]; // 开始更新
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates]; // 结束更新
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        [self.tableView moveRowAtIndexPath:indexPath
                               toIndexPath:newIndexPath];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSAssert(NO, @"");
    }
}

- (void)setFetchResultsController:(NSFetchedResultsController *)fetchResultsController {
    NSAssert(_fetchResultsController == nil, @"TODO: you can currently only assign this property once");
    _fetchResultsController = fetchResultsController;
    fetchResultsController.delegate = self;
    [fetchResultsController performFetch:NULL];
}


- (id)selectedItem {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    return indexPath ? [self.fetchResultsController objectAtIndexPath:indexPath] : nil;
}

- (void)setPaused:(BOOL)paused {
    _paused = paused;
    if (paused) {
        self.fetchResultsController.delegate = nil;
    } else {
        self.fetchResultsController.delegate = self;
        [self.fetchResultsController performFetch:NULL];
        [self.tableView reloadData];
    }
}



@end
