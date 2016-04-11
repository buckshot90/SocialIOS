//
//  AppDelegate.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 09.10.15.
//  Copyright © 2015 Oleh Petrunko. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "POOMessagesViewController.h"
#import "POOLogInVKViewController.h"
#import "POOLikedViewController.h"


static NSArray *SCOPE = nil;

@interface AppDelegate () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initVKSdk];
    //[VKSdk forceLogout];
    self.friendListViewController = [[POFriendsListViewController alloc]init];
    UINavigationController *friendListNavigationConrloller = [[UINavigationController alloc] initWithRootViewController:self.friendListViewController];
    friendListNavigationConrloller.tabBarItem.title = @"Friend list Tab";
    
    self.friendPhotoViewController = [[POOFriendPhotoViewController alloc] init];
    UINavigationController *friedPhotoNavigationController = [[UINavigationController alloc] initWithRootViewController: self.friendPhotoViewController];
    friedPhotoNavigationController.tabBarItem.title = @"Photo collection tab";
    
    self.feedViewController = [[POOFeedViewController alloc] init];
    UINavigationController *feedNavigattionController = [[UINavigationController alloc] initWithRootViewController:self.feedViewController];
    feedNavigattionController.tabBarItem.title = @"Feed";
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[friendListNavigationConrloller,friedPhotoNavigationController,feedNavigattionController];
    
    POOFacebookData *facebookDateViewController = [[POOFacebookData alloc] init];
    UINavigationController *navigationFacebookDateViewController = [[UINavigationController alloc] initWithRootViewController:facebookDateViewController];
    
    
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            [self buildTabBar];
            [self.window setRootViewController:self.tabBarController];
            [self.window makeKeyAndVisible];
        } else {
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window setRootViewController:navigationFacebookDateViewController];
            [self.window makeKeyAndVisible];
        }
    }];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                      didFinishLaunchingWithOptions:launchOptions];
}

- (void)initVKSdk {
    SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [[VKSdk initializeWithAppId:@"5187957"] registerDelegate:self];
    //[[VKSdk instance] setUiDelegate:self];
}

- (void)buildTabBar {
    UINavigationController *navControllerloginViewController = [[UINavigationController alloc] initWithRootViewController:[[POOLogInVKViewController alloc] init]];
    navControllerloginViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:[UIImage imageNamed:@"DockContacts"] tag:0];
    
    UINavigationController *navControllerMessagesViewController = [[UINavigationController alloc] initWithRootViewController:[[POOMessagesViewController alloc] init]];
    navControllerMessagesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Message" image:[UIImage imageNamed:@"DockMessages"] tag:1];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([POOLikedViewController class]) bundle:nil];
    POOLikedViewController *likedViewController = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([POOLikedViewController class])];
    UINavigationController *likedViewControllerNavigationController = [[UINavigationController alloc] initWithRootViewController:likedViewController];
    likedViewControllerNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Liked" image:[UIImage imageNamed:@"DockFaves"] tag:2];
    
    self.tabBarController.viewControllers = @[likedViewControllerNavigationController,  navControllerMessagesViewController, navControllerloginViewController];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - CoreData
- (NSManagedObjectContext *) manegedObjectContext {
    if (self.managedObjectContext) {
        
        return self.managedObjectContext;
    }
    
    if (self.persistentStoreCoordinator) {
        
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return self.managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (self.managedObjectModel) {
        return self.managedObjectModel;
    }
    
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Friend" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    return self.managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (self.persistentStoreCoordinator) {
        return self.persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [(NSURL *)[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OutputFaceBookData.sqlite"];
    
    NSError *error;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return self.persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        
    }
    if (result.error) {
        NSLog(@"Error:%@",result.error);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"vkSdkUserAuthorizationFailed");
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"vkSdkNeedCaptchaEnter");
}

@end
