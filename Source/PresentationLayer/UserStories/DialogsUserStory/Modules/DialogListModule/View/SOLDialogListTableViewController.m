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
#import "SOLDialogTableViewCell.h"
#import "SOLDialogDataDisplaymanager.h"
#import "SOLDialogListViewInput.h"
#import "SOLDialogListViewOutput.h"

#import "SOLUserService.h"
#import "SOLUserServiceImplementation.h"
#import "SOLUserServiceAssembly.h"

@interface SOLDialogListTableViewController () <SOLDialogDataDisplayManagerDelegate, SOLDialogDataDisplayManagerDataSource>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SOLDialogListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.output setupView];
}

#pragma mark - SOLDialogListViewInput

- (void)setupViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
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
    
    SOLUserServiceImplementation *service = [SOLUserServiceAssembly userService];
    [service updateUsersWithPredicate:nil completionBlock:^(NSArray<SOLUserPlainObject *> *list, NSError *error) {
        
    }];
}

- (void)updateViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
    [self.dataDisplayManager updateTableViewModelWithPlainObjects: dialogs];
}

#pragma mark - SOLDialogDataDisplayManagerDelegate

- (void)didUpdateTableView {
    
    [self.tableView reloadData];
}

- (void)didTapCellWithDialog:(SOLMessagePlainObject *)dialog {
    
    [self.output didTriggerTapCellWithMessage:dialog];
}

- (UISearchController *)searchResultsController {
    
    return _searchController;
}

@end