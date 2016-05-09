//
//  Item.m
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "Item.h"

@implementation Item

// Insert code here to add functionality to your managed object subclass

+ (NSString *)entityName {
    return @"Item";
}

+ (Item *)insertItemWithTitle:(NSString *)title
                       parent:(Item *)parent
       inManagedObjectContext:(NSManagedObjectContext *)context
{
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
    
    NSInteger order = [parent numberOfChildren];
    
    item.title = title;
    item.parent = parent;
    item.order = @(order);
    
    return item;
}

- (NSInteger)numberOfChildren {
    return self.children.count;
}


- (NSFetchedResultsController *)childrenFetchedResultsController
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:[self.class entityName]];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", self];
    // 排序, 降序
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];
    
    NSFetchedResultsController *fetchContriller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                      managedObjectContext:self.managedObjectContext
                                                                                        sectionNameKeyPath:nil
                                                                                                 cacheName:nil];
    return fetchContriller;
}

- (void)prepareForDeletion
{
    if (self.parent.isDeleted) return;
    
    NSSet* siblings = self.parent.children;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"order > %@", self.order];
    NSSet* itemsAfterSelf = [siblings filteredSetUsingPredicate:predicate];
    [itemsAfterSelf enumerateObjectsUsingBlock:^(Item* sibling, BOOL* stop)
     {
         sibling.order = @(sibling.order.integerValue - 1);
     }];
}



@end
