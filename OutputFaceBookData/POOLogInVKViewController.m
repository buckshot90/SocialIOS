//
//  POOLogInVKViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 14.01.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOLogInVKViewController.h"
#import "StringLocalizer.h"
#import "Consts.h"
#import "POOContactServiceImplementation.h"
#import "POOFriendServiceImplementation.h"
#import "POOContactsViewController.h"
#import "POOFriendsViewController.h"
#import "POOInvaitsViewController.h"

@interface POOLogInVKViewController ()

@property (strong, nonatomic) UISegmentedControl *segmentController;

@property (weak, nonatomic) IBOutlet UIView *contactsContainer;
@property (weak, nonatomic) IBOutlet UIView *friendsContainer;
@property (weak, nonatomic) IBOutlet UIView *invitesView;
@property (strong, nonatomic) id<POOContactService> contactServise;
@property (strong, nonatomic) id<POOFriendService> friendServise;


@end

@implementation POOLogInVKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self headerConfig];
    [self creatSegmentController];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.segmentController setWidth:(self.view.frame.size.width / 3) -10 forSegmentAtIndex:0];
    [self.segmentController setWidth:(self.view.frame.size.width / 3) -10 forSegmentAtIndex:1];
    [self.segmentController setWidth:(self.view.frame.size.width / 3) -10 forSegmentAtIndex:2];
}

- (void)creatSegmentController {
    self.segmentController = [[UISegmentedControl alloc] initWithItems:@[[@"segmentControllerContactText" localized],[@"segmentControllerFriendsText" localized], [@"segmentControllerInvitesText" localized]]];
    
    self.segmentController.layer.cornerRadius = 6.0f;
    self.segmentController.clipsToBounds = YES;
    
    self.segmentController.tintColor = [UIColor whiteColor];
    [self.segmentController setBackgroundImage:[UIImage imageNamed:@"Button_tab"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentController addTarget:self action:@selector(segmentSwithcher:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentController;
    self.segmentController.selectedSegmentIndex = 0;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.hidesBarsOnSwipe = NO;
}

- (void)headerConfig {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"Header_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}

- (void)segmentSwithcher:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0) {
        self.contactsContainer.hidden = NO;
        self.friendsContainer.hidden = YES;
        self.invitesView.hidden = YES;
    }
    if (segment.selectedSegmentIndex == 1) {
        self.contactsContainer.hidden = YES;
        self.friendsContainer.hidden = NO;
        self.invitesView.hidden = YES;
    }
    if (segment.selectedSegmentIndex == 2) {
        self.contactsContainer.hidden = YES;
        self.friendsContainer.hidden = YES;
        self.invitesView.hidden = NO;
    }
}

- (void)transferContactsWithSegue:(UIStoryboardSegue *)segue {
    if(_friendServise == nil) {
        
        self.friendServise = [[POOFriendServiceImplementation alloc] init];
    }
    
    if ([segue.destinationViewController isKindOfClass:[POOFriendsViewController class]]) {
        POOFriendsViewController *friendViewController = segue.destinationViewController;
        
        NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
        
        [self.friendServise getFriendsInfoWithId:[NSString stringWithFormat:@"%@",[userDefult objectForKey:kConstsUserIdKey]] order:@"hints" block:^(NSArray<POOVKUserModel *> *response, NSError *error) {
            friendViewController.friends = response;
            [friendViewController reloadData];
        }];
    }
}

- (void)transferFriendsWithSegue:(UIStoryboardSegue *)segue {
    if (_contactServise == nil) {
        
        self.contactServise = [[POOContactServiceImplementation alloc] init];
    }
    
    if ([segue.destinationViewController isKindOfClass:[POOContactsViewController class]]) {
        
        POOContactsViewController *contactsViewController = segue.destinationViewController;
        contactsViewController.contacts = [self.contactServise getAllContacts];
    }
}

- (void)transferInvitesWithSegue:(UIStoryboardSegue *)segue {
    POOFriendServiceImplementation *friendService = [[POOFriendServiceImplementation alloc] init];
    
    NSMutableArray *invites = [NSMutableArray array];
    
    if(_friendServise == nil) {
        
        self.friendServise = [[POOFriendServiceImplementation alloc] init];
    }
    
    if ([segue.destinationViewController isKindOfClass:[POOInvaitsViewController class]]) {
        POOInvaitsViewController *contactsViewController = segue.destinationViewController;
        
        [friendService getInvitesWith:YES needMutual:YES out:NO block:^(NSArray<POOVKUserModel *> *response, NSError *error) {
            [invites addObject:response];
            [friendService getInvitesWith:YES needMutual:YES out:YES block:^(NSArray<POOVKUserModel *> *response, NSError *error) {
                [invites addObject:response];
                [friendService GetFollowersWithId:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:kConstsUserIdKey]] offset:0 count:20 block:^(NSArray<POOVKUserModel *> *response, NSError *error) {
                    [invites addObject:response];
                    [friendService getSuggestionsWithFilter:@"mutual" count:20 offset:0 block:^(NSArray<POOVKUserModel *> *response, NSError *error) {
                        [invites addObject:response];
                        contactsViewController.invites = invites;
                        [contactsViewController reloadData];
                    }];
                }];
            }];
        }];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self transferContactsWithSegue:segue];
    [self transferFriendsWithSegue:segue];
    [self transferInvitesWithSegue:segue];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
