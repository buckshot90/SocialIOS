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
    
    _dataDisplayManager.delegate = self;
    self.tableView.delegate = _dataDisplayManager;
    self.tableView.dataSource = _dataDisplayManager;
    
    typeof(self) __weak weakSelf = self;
    self.service = [SOLMessageServiceAssembly messageService];
    [_service updateDialogWithPredicate:nil completionBlock:^(NSArray<SOLMessagePlainObject *> *list, NSError *error) {
        typeof(self) __strong strongSelf = weakSelf;
        
        if(strongSelf) {
            
            [strongSelf.dataDisplayManager updateTableViewModelWithPlainObjects: list];
        }
    }];
}

#pragma mark - SOLDialogDataDisplayManagerDelegate

- (void)didUpdateTableView {
    
    [self.tableView reloadData];
}

- (void)didTapCellWithDialog:(SOLMessagePlainObject *)dialog {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
