//
//  AppDelegate.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 09.10.15.
//  Copyright © 2015 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "POOFacebookData.h"
#import "POOFriendPhotoViewController.h"
#import "POFriendsListViewController.h"
#import "POOWebController.h"
#import "POOFeedViewController.h"
#import "POORegistrationViewController.h"
#import "vkSdk.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) POFriendsListViewController *friendListViewController;
@property (nonatomic, strong) POOFriendPhotoViewController *friendPhotoViewController;
@property (nonatomic, strong) POOWebController *webViewController;
@property (nonatomic, strong) POOFeedViewController *feedViewController;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end

