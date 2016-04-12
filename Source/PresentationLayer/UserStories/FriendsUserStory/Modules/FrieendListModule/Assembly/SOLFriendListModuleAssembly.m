//
//  SOLFriendListModuleAssembly.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLFriendListModuleAssembly.h"
#import "SOLFriendListTableViewController.h"
#import "SOLFriendListCellObjectBuilder.h"

@interface SOLFriendListModuleAssembly ()

@property (weak, nonatomic) IBOutlet SOLFriendListTableViewController *viewController;

@end

@implementation SOLFriendListModuleAssembly

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureModuleForViewInput:_viewController];
}

- (void)configureModuleForViewInput:(SOLFriendListTableViewController *)viewInput {
    
    if(viewInput != nil) {
        
        [self configure:viewInput];
    }
}

- (void)configure:(SOLFriendListTableViewController *)viewController {
    
    viewController.dataDisplayManager = [self dataDisplayManager];
}
- (SOLFriendListDataDisplayManager *)dataDisplayManager {
    
    SOLFriendListDataDisplayManager *dataDisplayManager = [[SOLFriendListDataDisplayManager alloc] init];
    dataDisplayManager.cellObjectBuilder = [self cellObjectBuilder];
    return dataDisplayManager;
}

- (SOLFriendListCellObjectBuilder *)cellObjectBuilder {
    
    return [[SOLFriendListCellObjectBuilder alloc] init];
}

@end
