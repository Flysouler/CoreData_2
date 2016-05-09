//
//  TableViewController.m
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "TableViewController.h"

#import "Item.h"
#import "Store.h" 
#import "FetchedResultsControllerDataSource.h"

static NSString *identifer = @"selectedItem";

@interface TableViewController () <FetchedResultsControllerDataSourceDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) FetchedResultsControllerDataSource *fetchDataSource;

@end

@implementation TableViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self hideNewItemField];
    }
    
    self.fetchDataSource.paused = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.fetchDataSource.paused = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupFetchedController];
    
    [self setupNewItemField];
}


- (void)setupFetchedController {
    self.tableView.dataSource = nil;
    self.fetchDataSource = [[FetchedResultsControllerDataSource alloc] initWithTableView:self.tableView];
    self.fetchDataSource.fetchResultsController = self.parent.childrenFetchedResultsController;
    self.fetchDataSource.delegate = self;
    self.fetchDataSource.reuseIdentifer = @"Cell";
}

- (void)setupNewItemField {
    self.textField = [[UITextField alloc] initWithFrame:(CGRect){0, 0, CGRectGetWidth(self.tableView.frame), 40}];
    self.textField.delegate = self;
    self.textField.placeholder = NSLocalizedString(@"Add a new Item", @"Placeholder text for add a new item!");
    self.tableView.tableHeaderView = self.textField;
}

#pragma mark -textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = textField.text;
    NSString *actionName = text;
    [self.undoManager setActionName:actionName];
    
    [Item insertItemWithTitle:text parent:self.parent inManagedObjectContext:self.managedObjectContext];
    textField.text = @"";
    [textField resignFirstResponder];
    [self hideNewItemField];
    return NO;
}

#pragma mark -隐藏/ 显示 textField
- (void)hideNewItemField {
    UIEdgeInsets edges = self.tableView.contentInset;
    edges.top = -CGRectGetHeight(self.textField.frame);
    self.tableView.contentInset = edges;
}

- (void)showNewItemField {
    UIEdgeInsets edges = self.tableView.contentInset;
    edges.top = 0;
    self.tableView.contentInset = edges;
}

#pragma mark -dailie
- (void)configureCell:(id)cell withObject:(id)object {
    UITableViewCell *cellss = cell;
    Item *item = object;
    
    cellss.textLabel.text = item.title;
}

- (void)deleteObject:(id)object {
    Item *item = object;
    NSString *actionName = item.title;
    [self.undoManager setActionName:actionName];
    
    [item.managedObjectContext deleteObject:item];
}

#pragma mark -segues 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:identifer]) {
        [self presentItemSubViewController:segue.destinationViewController];
    }
}

- (void)presentItemSubViewController:(TableViewController *)Controller {
    Item *item = [self.fetchDataSource selectedItem];
    Controller.parent = item;
}

#pragma mark -scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (-scrollView.contentOffset.y > CGRectGetHeight(self.textField.frame)) {
        [self showNewItemField];
        [self.textField becomeFirstResponder];
    } else if (scrollView.contentOffset.y > 0 ) {
        [self hideNewItemField];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BOOL isShow = self.tableView.contentInset.top == 0;
    if (isShow) {
        [self.textField becomeFirstResponder];
    }
}



- (void)setParent:(Item *)parent {
    _parent = parent;
    self.navigationItem.title = parent.title;
}


#pragma mark -undo
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSUndoManager *)undoManager {
    return  self.managedObjectContext.undoManager;
}

- (NSManagedObjectContext *)managedObjectContext {
    return self.parent.managedObjectContext;
}





@end
