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

@interface SOLDialogListTableViewController ()
@property (strong, nonatomic) NSArray<SOLMessagePlainObject *> *dialogList;
@property (strong, nonatomic) id <SOLMessageService> service;
@end

@implementation SOLDialogListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[SOLDialogTableViewCell class] forCellReuseIdentifier:@"SOLDialogTableViewCell"];
    
    typeof(self) __weak weakSelf = self;
    self.service = [SOLMessageServiceAssembly messageService];
    [_service updateDialogWithPredicate:nil completionBlock:^(NSArray<SOLMessagePlainObject *> *list, NSError *error) {
        typeof(self) __strong strongSelf = weakSelf;
        
        if(strongSelf) {
            
            strongSelf.dialogList = list;
            [strongSelf.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dialogList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOLDialogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SOLDialogTableViewCell" forIndexPath:indexPath];
    
    SOLMessagePlainObject *dialog = [self.dialogList objectAtIndex:indexPath.row];
    NSString *body = dialog.body;
    cell
//    NSLog(@"indexpath: %li, body: %@", (long)indexPath.row, body);
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
