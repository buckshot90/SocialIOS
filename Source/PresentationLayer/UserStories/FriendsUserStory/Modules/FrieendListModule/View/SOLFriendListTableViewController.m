//
//  SOLFriendListTableViewController.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLFriendListTableViewController.h"

#import "SOLUserService.h"
#import "SOLUserServiceImplementation.h"
#import "SOLUserServiceAssembly.h"

#import "SOLFriendListDataDisplayManager.h"

@interface SOLFriendListTableViewController () <SOLDataDisplayManagerDelegate, SOLDataDisplayManagerDataSource>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SOLFriendListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_output viewDidLoad];
}

#pragma mark - SOLFriendListViewInput

- (void)setupViewWithFriendList:(NSArray<SOLUserPlainObject *> *)friends {
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    _dataDisplayManager.delegate = self;
    _dataDisplayManager.dataSource = self;
    self.tableView.delegate = _dataDisplayManager;
    self.tableView.dataSource = _dataDisplayManager;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = _dataDisplayManager;
    self.searchController.searchBar.delegate = _dataDisplayManager;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.scopeButtonTitles = @[@"All", @"Online"];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.dataDisplayManager updateTableViewModelWithPlainObjects: friends];
}

- (void)updateViewWithFriendList:(NSArray<SOLUserPlainObject *> *)friends {
//    NSLog(@"friends: %@", friends);
    [self.dataDisplayManager updateTableViewModelWithPlainObjects: friends];
}

#pragma mark - UIRefreshControl

- (void)refresh:(id)sender {
    
    [_output refreshData];
}

#pragma mark - SOLDataDisplayManagerDelegate

- (void)didUpdateTableView {
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didTapCellWithPlainObject:(id<SOLPlainObject>)plainObj {
    
    [_output didSelectCellWithFriend:plainObj];
}

#pragma mark - SOLDataDisplayManagerDataSource

- (UISearchController *)searchResultsController {
    
    return _searchController;
}

@end
