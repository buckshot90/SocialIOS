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

@interface SOLDialogListTableViewController () <SOLDialogDataDisplayManagerDelegate>

@property (strong, nonatomic) id <SOLMessageService> service;

@end

@implementation SOLDialogListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self.output setupView];
}

#pragma mark - SOLDialogListViewInput

- (void)setupViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
    _dataDisplayManager.delegate = self;
    self.tableView.delegate = _dataDisplayManager;
    self.tableView.dataSource = _dataDisplayManager;
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

@end