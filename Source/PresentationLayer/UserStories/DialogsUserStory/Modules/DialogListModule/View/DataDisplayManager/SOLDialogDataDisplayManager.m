//
//  SOLDialogDataDisplayManager.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogDataDisplayManager.h"
#import "SOLDialogTableViewCellObject.h"
#import "SOLDialogTableViewCell.h"
#import "SOLDataDisplayManager.h"

@interface SOLDialogDataDisplayManager ()

@property (strong, nonatomic) NSArray<SOLDialogTableViewCellObject *> *cellObjs;
@property (strong, nonatomic) NSArray *plainObjs;

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) BOOL registeredNib;

@end

@implementation SOLDialogDataDisplayManager

- (void)updateTableViewModelWithPlainObjects:(NSArray *)plainObjs {
    
    self.plainObjs = plainObjs;
    self.cellObjs = [self.cellObjectBuilder cellObjectsForPlainObjects:_plainObjs];
    [self.delegate didUpdateTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [SOLDialogTableViewCell heightForObject:_cellObjs[indexPath.row] atIndexPath:indexPath tableView:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cellObjs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_registeredNib) {
        
        self.registeredNib = YES;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SOLDialogTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([SOLDialogTableViewCell class])];
    }
    
    SOLDialogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SOLDialogTableViewCell class])];
    [cell shouldUpdateCellWithObject:_cellObjs[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate didTapCellWithDialog:_plainObjs[indexPath.row]];
}

@end
