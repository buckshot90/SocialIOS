//
//  POOFriendsViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 13.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOFriendsViewController.h"
#import "POOVKUserModel.h"
#import "POOVkFriendTableViewCell.h"
#import "POOFriendServiceImplementation.h"
#import "Consts.h"

static NSString *MyIdentifier = @"FriendCellIdentefier";

@interface POOFriendsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) NSDictionary *searchFriends;
@property (strong, nonatomic) NSDictionary *friendsBySections;
@property (strong, nonatomic) NSArray<NSString *> *sections;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic, readwrite) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *userId;

@end

@implementation POOFriendsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.searchFriends = [NSDictionary dictionary];
        self.friendsBySections = [NSDictionary dictionary];
        self.sections = [NSArray array];
        self.userId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kConstsUserIdKey]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

- (void)reloadData {
    self.friendsBySections = [self getSortedArrayBySection:_friends];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)getSortedArrayBySection:(NSArray *)array {
    NSMutableArray *sectionsKey = [[NSMutableArray alloc] init];
    NSMutableDictionary *friendsBySections = [NSMutableDictionary dictionary];
    
    for (POOVKUserModel *user in array) {
        [self creatFriendsArray:user sectionsKey:sectionsKey friendsBySections:friendsBySections];
    }
    [sectionsKey sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return friendsBySections;
}

- (void)creatFriendsArray:(POOVKUserModel *)user sectionsKey:(NSMutableArray *)sectionsKey friendsBySections:(NSMutableDictionary *)friendsBySections {
    NSString *sectionName = [user.name substringToIndex:1];
    NSMutableArray *nameInSection = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", sectionName];
    NSArray *foundSection = [sectionsKey filteredArrayUsingPredicate:predicate];
    
    if (foundSection.count) {
        nameInSection = [friendsBySections objectForKey:sectionName];
    } else {
        nameInSection = [NSMutableArray array];
        [sectionsKey addObject:sectionName];
    }
    
    [nameInSection addObject:user];
    [friendsBySections setObject:nameInSection forKey:sectionName];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
       return self.searchFriends.allKeys.count;
    }
    return self.friendsBySections.allKeys.count ;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = nil;
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        array = self.searchFriends.allKeys;
        return [[self.searchFriends objectForKey:[array objectAtIndex:section]] count];
    }
    array = self.friendsBySections.allKeys;
    return [[self.friendsBySections objectForKey:[array objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        return self.searchFriends.allKeys;
    }
    return self.friendsBySections.allKeys;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        return [self.searchFriends.allKeys objectAtIndex:section];
    }
    return [self.friendsBySections.allKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    POOVkFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"POOVkFriendTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    POOVKUserModel *user = nil;
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        NSString *curentKey = [self.searchFriends.allKeys objectAtIndex:indexPath.section];
        NSArray * currentNames = [self.searchFriends objectForKey:curentKey];
        user = [currentNames objectAtIndex:indexPath.row];
    }
    
    NSString *curentKey = [self.friendsBySections.allKeys objectAtIndex:indexPath.section];
    NSArray * currentNames = [self.friendsBySections objectForKey:curentKey];
    user = [currentNames objectAtIndex:indexPath.row];
    
    [cell configWithName:user.name secondName:user.lastName online:user.online image:user.image];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    NSMutableArray *filtreadArray = [NSMutableArray array];
    if (![searchString isEqualToString:@""]) {
        for (NSString *key in self.friendsBySections.allKeys) {
            for (POOVKUserModel *user in [self.friendsBySections objectForKey:key]) {
                if ([user.name localizedCaseInsensitiveContainsString:searchString] || [user.lastName localizedCaseInsensitiveContainsString:searchString])  {
                    [filtreadArray addObject:user];
                }
            }
        }
        self.searchFriends = [self getSortedArrayBySection:filtreadArray];
    }
    
    [self.tableView reloadData];
}

- (void)buildUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;
}

@end
