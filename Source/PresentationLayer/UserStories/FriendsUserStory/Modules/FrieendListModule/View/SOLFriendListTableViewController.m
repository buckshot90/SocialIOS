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
@property (strong, nonatomic) SOLUserServiceImplementation *service;

@end

@implementation SOLFriendListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.service = [SOLUserServiceAssembly userService];
    [_service updateUsersWithPredicate:nil completionBlock:^(NSArray<SOLUserPlainObject *> *list, NSError *error) {
        
        [self.dataDisplayManager updateTableViewModelWithPlainObjects: list];
    }];
}

#pragma mark - SOLDataDisplayManagerDelegate

- (void)didUpdateTableView {
    
    [self.tableView reloadData];
}

- (void)didTapCellWithPlainObject:(id<SOLPlainObject>)plainObj {
    
}

#pragma mark - SOLDataDisplayManagerDataSource

- (UISearchController *)searchResultsController {
    
    return _searchController;
}

@end
