//
//  POOMessagesViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 15.03.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOMessagesViewController.h"
#import "Consts.h"
#import "String+Md5.m"
#import "POOUserDialog.h"
#import "POOVKUserModel.h"
#import "POOVkMessageTableViewCell.h"
#import "POORequstManager.h"
#import "StringLocalizer.h"

static NSString *MessagesIdent = @"MessagesIdent";

@interface POOMessagesViewController () <UITableViewDataSource, UITabBarDelegate>

@property (strong, nonatomic) NSMutableArray *dialogs;
@property (strong, nonatomic) NSMutableArray *friends;
@property (assign, nonatomic) NSInteger index;

@end

@implementation POOMessagesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dialogs = [NSMutableArray array];
        self.friends = [NSMutableArray array];
        self.index = 50;
        
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self headerConfig];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([POOVkMessageTableViewCell class])  bundle:nil] forCellReuseIdentifier:MessagesIdent];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.dialogs removeAllObjects];
    [self getDialogs:self.index offset:0];
}

- (void)getDialogs:(NSInteger)count offset:(NSInteger)offset {
    [POORequstManager getDialogs:count offset:offset block:^(NSArray *response, NSError *error) {
        [self.dialogs addObjectsFromArray:response];
        
        typeof(self) __weak weakSelf = self;
        [POORequstManager getUserInfoWithIds:[self getUserIds] block:^(NSArray *response, NSError *error) {
            typeof(self) __strong strongSelf = weakSelf;
            
            if (strongSelf != nil) {
                
                [strongSelf.friends removeAllObjects];
                
                [strongSelf.friends addObjectsFromArray:response];
                [strongSelf.tableView reloadData];
            }
        }];
    }];
}

- (NSArray *)getUserIds {
    NSMutableArray *userdIs = [NSMutableArray arrayWithCapacity:[self.dialogs count]];
    
    for (POOUserDialog *userDialog in self.dialogs) {
        if (!userDialog.chat) {
            [userdIs addObject:[NSNumber numberWithInteger:userDialog.userId]];
        } else {
            [userdIs addObject:userDialog.chat.chatId];
        }
    }

    return userdIs;
}

#pragma mark - TableView delegat and datasourse
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogs.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    POOVkMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessagesIdent];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([POOVkMessageTableViewCell class]) owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    POOUserDialog *userDialog = self.dialogs[indexPath.row];
    POOVKUserModel *user;
    if (indexPath.row < self.friends.count) {
        user = self.friends[indexPath.row];
    }
    
    [cell initWithInterlocutorImage:user.image interlocutorNameAndSecondname:[NSString stringWithFormat:@"%@ %@",user.name, user.lastName] message:userDialog.body online:user.online outbox:userDialog.outbox readFlag:userDialog.readFlag];
    
    if (indexPath.row == self.dialogs.count - 1) {
        [self getDialogs:20 offset:self.dialogs.count];
    }
    
    self.index = [[tableView indexPathsForVisibleRows] lastObject].row + 1;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)headerConfig {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"Header_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.topItem.title = [@"Message" localized];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory worning");
}

@end
