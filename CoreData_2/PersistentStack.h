//
//  PersistentStack.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface PersistentStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL;

- (void)saveContext;

@end
