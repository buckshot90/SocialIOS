//
//  POFacebookData.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 09.10.15.
//  Copyright © 2015 Oleh Petrunko. All rights reserved.
//

#import "AppDelegate.h"
#import "POOFacebookData.h"
#import "POOTESTFriend.h"
#import "POOFacebookFeed.h"
#import "POOLogInVKViewController.h"
#import "POOMessagesViewController.h"
#import "vkSdk.h"
#import "StringLocalizer.h"
#import "Consts.h"

static NSArray *SCOPE = nil;

@interface POOFacebookData () <VKSdkDelegate, VKSdkUIDelegate, UIWebViewDelegate>

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation POOFacebookData

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.tabBarController = [[UITabBarController alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
    [self creatLoginButtotAndAddToSubView];
    
    //[VKSdk forceLogout];
    SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [[VKSdk initializeWithAppId:@"5187957"] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                      openURL:url
                                                      sourceApplication:sourceApplication
                                                      annotation:annotation];
}

- (void)buildTabBar {
    UINavigationController *navControllerloginViewController = [[UINavigationController alloc] initWithRootViewController:[[POOLogInVKViewController alloc] init]];
    navControllerloginViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:[UIImage imageNamed:@"DockContacts"] tag:0];
    
    UINavigationController *navControllerMessagesViewController = [[UINavigationController alloc] initWithRootViewController:[[POOMessagesViewController alloc] init]];
    navControllerMessagesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Message" image:[UIImage imageNamed:@"DockMessages"] tag:1];
    
    
    self.tabBarController.viewControllers = @[navControllerloginViewController, navControllerMessagesViewController];
}

#pragma mark - Button cliked
-(void)loginButtonClicked
{
    [self getListOfFriends];
    [self getFeed];
}
#pragma mark - Get feed
- (void) getFeed {
    FBSDKGraphRequest *feedRequest = [[FBSDKGraphRequest alloc]initWithGraphPath:@"/me/posts?fields=attachments,message,created_time" parameters:nil];
    
    [feedRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        NSArray *feedArray = [result objectForKey:@"data"];
        NSMutableArray *feeds = [[NSMutableArray alloc] initWithCapacity:feedArray.count];
        
        for (NSDictionary *feed in feedArray) {
            POOFacebookFeed *POOfeed = [[POOFacebookFeed alloc]initWithDictionary:feed];
            [feeds addObject:POOfeed];
        }
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.feedViewController initWithArray:feeds];
    }];
}
#pragma mark - Get friends
- (void) getListOfFriends {
    
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        [login logInWithReadPermissions:@[@"public_profile", @"user_friends",@"user_posts",@"user_about_me"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

    
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest *friendsRequest =
                [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/taggable_friends"
                                                  parameters:nil];
                
                FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
                
    
                [connection addRequest:friendsRequest
                     completionHandler:^(FBSDKGraphRequestConnection* innerConnection, id result, NSError *error) {
                         
                         NSArray *friendList = [result objectForKey:@"data"];
                         
                         NSMutableArray *friends = [NSMutableArray arrayWithCapacity:friendList.count];
                         
                         for (NSDictionary *friendDict in friendList) {
                             POOTESTFriend *friend = [[POOTESTFriend alloc] initWithDictionary:friendDict];
                             [friends addObject:friend];
                         }
                         AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                         [appDelegate.friendListViewController initWithFriends:friends];
                         [appDelegate.friendPhotoViewController initByArray:friends];
                         [appDelegate.window setRootViewController:appDelegate.tabBarController];

                     }];
                [connection start];
            }
        }];
}

#pragma mark - button creat
- (void) creatLoginButtotAndAddToSubView {
    UIButton *facebookLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookLoginButton.backgroundColor = [UIColor darkGrayColor];
    [facebookLoginButton setTitle: [@"facebookLoginButtonText" localized] forState: UIControlStateNormal];
    [facebookLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *vkLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vkLoginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton"] forState:UIControlStateNormal];
    [vkLoginButton setTitle: [@"vkLoginButtonText" localized] forState: UIControlStateNormal];
    [vkLoginButton addTarget:self action:@selector(vkLoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *vkRegistration = [[UIButton alloc] init];
    [vkRegistration setTitle:[@"vkRegistrationText" localized] forState:UIControlStateNormal];
    [vkRegistration setBackgroundImage:[UIImage imageNamed:@"RegButton"] forState:UIControlStateNormal];
    [vkRegistration addTarget:self action:@selector(vkRegistration) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Header"]];
    header.contentMode = UIViewContentModeScaleToFill;
    UILabel *helloLable = [[UILabel alloc] init];
    helloLable.textColor = [UIColor whiteColor];
    helloLable.text = [@"headerText" localized];
    
    [self.view addSubview:facebookLoginButton];
    [self.view addSubview:vkLoginButton];
    [self.view addSubview:vkRegistration];
    [self.view addSubview:header];
    [self.view addSubview:helloLable];
    
    [self creatConstraints:facebookLoginButton vkButton:vkLoginButton header:header helloLable:helloLable vkRegistration:vkRegistration];
}
#pragma mark - VK buttons
- (void) vkRegistration {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    POORegistrationViewController *registrationViewController = [[POORegistrationViewController alloc] init];
    appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:registrationViewController];
}

- (void) vkLoginButtonClicked   {
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            
            [self buildTabBar];
            [self presentViewController:self.tabBarController animated:YES completion:NULL];
        } else {
            
            [VKSdk authorize:SCOPE];
        }
    }];
}

#pragma mark - Constraints
- (void) creatConstraints:(UIButton *)facebookButton vkButton:(UIButton *)vkButton header:(UIImageView *)header helloLable:(UILabel *) lable vkRegistration:(UIButton *)vkRegistration   {
    
    if (self.view.constraints.count == 0) {
        
        facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
        vkButton.translatesAutoresizingMaskIntoConstraints = NO;
        header.translatesAutoresizingMaskIntoConstraints = NO;
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        vkRegistration.translatesAutoresizingMaskIntoConstraints = NO;
        //VK Vutton
        
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:vkButton
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                                  attribute:NSLayoutAttributeTop
                                  multiplier:1 constant:100]];
        
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:vkButton
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                                  attribute:NSLayoutAttributeLeading
                                  multiplier:1.0f constant:50]];
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.view
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:vkButton
                                  attribute:NSLayoutAttributeTrailing
                                  multiplier:1.0f constant:50]];
        
        //Facebook button
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:facebookButton
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:vkButton
                                  attribute:NSLayoutAttributeBottom
                                  multiplier:1.0f constant:5]];
        
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:facebookButton
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                                  attribute:NSLayoutAttributeLeading
                                  multiplier:1.0f constant:50]];
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.view
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:facebookButton
                                  attribute:NSLayoutAttributeTrailing
                                  multiplier:1.0f constant:50]];
        
        //VK registration Button
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:vkRegistration attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:facebookButton attribute:NSLayoutAttributeBottom multiplier:1.0f constant:20]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:vkRegistration attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:50]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:vkRegistration attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:50]];
        //header
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:header attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:20]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:header attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:header attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
         //lable
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:header attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lable attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    }
}

- (void) vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        
        [[NSUserDefaults standardUserDefaults] setObject:result.token.accessToken forKey:kConstsTokenKey];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:result.token.expiresIn] forKey:kConstsExpiresInKey];
        [[NSUserDefaults standardUserDefaults] setObject:result.user.id forKey:kConstsUserIdKey];
        [[NSUserDefaults standardUserDefaults] setObject:result.token.secret forKey:kConstsVkSecretKey];
        [[NSUserDefaults standardUserDefaults ] setObject:result.user.photo_100 forKey:kConstsUserPhotoKey];
        
        [self buildTabBar];
        
        [self presentViewController:self.tabBarController animated:YES completion:NULL];
    }
     if (result.error) {
        NSLog(@"Error:%@",result.error);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"vkSdkUserAuthorizationFailed");
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
      NSLog(@"vkSdkNeedCaptchaEnter");
}
@end
