//
//  POOInvaitsViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 14.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOInvaitsViewController.h"
#import "POOFriendServiceImplementation.h"
#import "POOVkFriendTableViewCell.h"
#import "StringLocalizer.h"
#import "Consts.h"

static NSString *MyIdentifier = @"InvitesIdentefire";

@interface POOInvaitsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *header;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation POOInvaitsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.header = [NSArray arrayWithObjects:[@"addToFriend" localized], [@"iSigned" localized], [@"Followers" localized], [@"Suggestions" localized], nil];
        self.invites = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.invites.count ;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.invites objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.header objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    POOVkFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([POOVkFriendTableViewCell class]) owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    NSArray *section = [self.invites objectAtIndex:indexPath.section];
    POOVKUserModel *user = [section objectAtIndex:indexPath.row];
    
    [cell configWithName:user.name secondName:user.lastName online:user.online image:user.image];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
