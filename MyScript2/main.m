//
//  main.m
//  MyScript2
//
//  Created by Jinwoo Kim on 5/2/24.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataGenerated/Model/Model+CoreDataModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSURL *bundleURL = [NSBundle.mainBundle bundleURL];
        NSURL *modelMomdURL = [bundleURL URLByAppendingPathComponent:@"Model.momd" isDirectory:YES];
        NSURL *model_v0_URL = [modelMomdURL URLByAppendingPathComponent:@"Model.mom" isDirectory:NO];
        
        NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:model_v0_URL];
        
        
        NSURL *desktopURL = [NSFileManager.defaultManager URLsForDirectory:NSDesktopDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *containerURL = [desktopURL URLByAppendingPathComponent:@"default.splite"];
        NSPersistentStoreDescription *persistentStoreDescription = [[NSPersistentStoreDescription alloc] initWithURL:containerURL];
        
//        persistentStoreDescription.type = NSInMemoryStoreType;
        persistentStoreDescription.shouldAddStoreAsynchronously = NO;
        
        NSPersistentContainer *persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Container" managedObjectModel:managedObjectModel];
        
        [persistentContainer.persistentStoreCoordinator addPersistentStoreWithDescription:persistentStoreDescription completionHandler:^(NSPersistentStoreDescription * _Nonnull desc, NSError * _Nullable error) {
            assert(error == nil);
        }];
        
        NSManagedObjectContext *context = [persistentContainer viewContext];
        
        char foo[4096];
        
        Entity *entity_1 = [[Entity alloc] initWithContext:context];
        entity_1.bytes = [[NSData alloc] initWithBytes:foo length:sizeof(foo)];
        
        NSError * _Nullable error = nil;
        [context save:&error];
        assert(error == nil);
        
        Entity *entity_2 = [[Entity alloc] initWithContext:context];
        entity_2.bytes = [[NSData alloc] initWithBytes:foo length:sizeof(foo)];
        
        [context save:&error];
        assert(error == nil);
    }
    return 0;
}
