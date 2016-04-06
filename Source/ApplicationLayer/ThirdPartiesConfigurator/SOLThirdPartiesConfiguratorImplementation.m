//
//  SOLThirdPartiesConfiguratorImplementation.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLThirdPartiesConfiguratorImplementation.h"
#import <VK_ios_sdk/VKSdk.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString * const kRCFCoreDataStoreName = @"OutputFaceBookData";

@interface SOLThirdPartiesConfiguratorImplementation () <VKSdkUIDelegate, VKSdkDelegate>
@property (strong, nonatomic) UIViewController *rootController;
@end

@implementation SOLThirdPartiesConfiguratorImplementation

#pragma mark - Public method

- (void)configure {
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *initialViewController = [sb instantiateInitialViewController];
    self.rootController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [self p_setupVkSdk];
    [self setupCoreDataStack];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    return [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSArray *SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [VKSdk authorize:SCOPE];
}

#pragma mark - Private method

- (void)setupCoreDataStack {
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:kRCFCoreDataStoreName];
}


- (void)p_setupVkSdk {
    
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:@"5399134"];
    [sdkInstance setUiDelegate:self];
    [sdkInstance registerDelegate:self];
    
    NSArray *SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        
        if (state == VKAuthorizationAuthorized) {
            // Authorized and ready to go
            [self.rootController dismissViewControllerAnimated:NO completion:^{}];
        } else if (error) {
            
//            [UIAlertController alertControllerWithTitle:nil message:[error description] preferredStyle: UIAlertControllerStyleAlert];
        }
    }];
}

#pragma mark - VKSdkDelegate
/**
 Notifies delegate about authorization was completed, and returns authorization result which presents new token or error.
 @param result contains new token or error, retrieved after VK authorization
 */
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    
}

/**
 Notifies delegate about access error, mostly connected with user deauthorized application
 */
- (void)vkSdkUserAuthorizationFailed {
 
//    [UIAlertController alertControllerWithTitle:nil message:@"Access denied" preferredStyle: UIAlertControllerStyleAlert];
//    [self.rootController.navigationController popToRootViewControllerAnimated:YES];
}

/**
 Notifies delegate about access token changed
 @param newToken new token for API requests
 @param oldToken previous used token
 */
- (void)vkSdkAccessTokenUpdated:(VKAccessToken *)newToken oldToken:(VKAccessToken *)oldToken {
    
}

/**
 Notifies delegate about existing token has expired
 @param expiredToken old token that has expired
 */
- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    
}

#pragma mark - VKSdkUIDelegate
/**
 Pass view controller that should be presented to user. Usually, it's an authorization window
 @param controller view controller that must be shown to user
 */
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    
    [self.rootController presentViewController:controller animated:YES completion:nil];
}

/**
 Calls when user must perform captcha-check
 @param captchaError error returned from API. You can load captcha image from <b>captchaImg</b> property.
 After user answered current captcha, call answerCaptcha: method with user entered answer.
 */
- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

/**
 * Called when a controller presented by SDK will be dismissed
 */
- (void)vkSdkWillDismissViewController:(UIViewController *)controller {
    
//    [self.rootViewController dismissViewControllerAnimated:YES completion:^{}];
}

/**
 * Called when a controller presented by SDK did dismiss
 */
- (void)vkSdkDidDismissViewController:(UIViewController *)controller {
    
}

@end
