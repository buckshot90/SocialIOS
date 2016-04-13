//
//  DialogListTableViewController.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogListTableViewController.h"
#import "SOLMessageService.h"
#import "SOLMessageServiceImplementation.h"
#import "SOLMessageServiceAssembly.h"
#import "SOLDataDisplayManager.h"
#import "SOLDialogDataDisplayManager.h"
#import "SOLDialogListViewInput.h"
#import "SOLDialogListViewOutput.h"

@interface SOLDialogListTableViewController () <SOLDataDisplayManagerDelegate, SOLDataDisplayManagerDataSource>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SOLDialogListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.output setupView];
}

#pragma mark - SOLDialogListViewInput

- (void)setupViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
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
    
    self.searchController.searchBar.scopeButtonTitles = @[@"Dialogs", @"Messages"];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)updateViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
    [self.dataDisplayManager updateTableViewModelWithPlainObjects: dialogs];
}

#pragma mark - UIRefreshControl

- (void)refresh:(id)sender {
    
    [_output refreshData];
}

#pragma mark - SOLDialogDataDisplayManagerDelegate

- (void)didUpdateTableView {
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didTapCellWithPlainObject:(id<SOLPlainObject>)plainObj {
    
    [self.output didTriggerTapCellWithMessage:plainObj];
}

- (UISearchController *)searchResultsController {
    
    return _searchController;
}

@end