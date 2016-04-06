//
//  AppDelegate.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 09.10.15.
//  Copyright © 2015 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SOLThirdPartiesConfigurator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) id <SOLThirdPartiesConfigurator> thirdPartiesConfigurator;

//@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (NSString *)applicationDocumentsDirectory;
//- (void)saveContext;

@end

