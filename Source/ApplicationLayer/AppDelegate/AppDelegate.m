//
//  AppDelegate.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 09.10.15.
//  Copyright © 2015 Oleh Petrunko. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "SOLThirdPartiesConfiguratorImplementation.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.thirdPartiesConfigurator configure];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    return [self.thirdPartiesConfigurator application:app openURL:url options:options];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.thirdPartiesConfigurator applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)saveContext {
//    NSError *error = nil;
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
//}
//
//#pragma mark - CoreData
//- (NSManagedObjectContext *) manegedObjectContext {
//    if (self.managedObjectContext) {
//        
//        return self.managedObjectContext;
//    }
//    
//    if (self.persistentStoreCoordinator) {
//        
//        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
//    }
//    
//    return self.managedObjectContext;
//}
//
//- (NSManagedObjectModel *)managedObjectModel {
//    if (self.managedObjectModel) {
//        return self.managedObjectModel;
//    }
//    
//    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Friend" withExtension:@"momd"];
//    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
//    
//    return self.managedObjectModel;
//}
//
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    if (self.persistentStoreCoordinator) {
//        return self.persistentStoreCoordinator;
//    }
//    
//    NSURL *storeURL = [(NSURL *)[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OutputFaceBookData.sqlite"];
//    
//    NSError *error;
//    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
//    
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//    
//    return self.persistentStoreCoordinator;
//}
//
//- (NSURL *)applicationDocumentsDirectory {
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}

@end
