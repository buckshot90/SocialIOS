//
//  SOLFriendListModuleAssembly.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLFriendListModuleAssembly.h"
#import "SOLFriendListTableViewController.h"
#import "SOLFriendListCellObjectBuilder.h"

#import "SOLUserServiceAssembly.h"

#import "SOLFriendListInteractor.h"
#import "SOLFriendListPresenter.h"
#import "SOLFriendListRouter.h"

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
    
    SOLFriendListPresenter *presenter = [[SOLFriendListPresenter alloc] init];
    
    SOLFriendListInteractor *interactor = [[SOLFriendListInteractor alloc] init];
    interactor.output = presenter;
    interactor.service = [SOLUserServiceAssembly userService];
    
    SOLFriendListRouter *router = [[SOLFriendListRouter alloc] init];
    
    presenter.interactor = interactor;
    presenter.router = router;
    presenter.view = viewController;
    
    viewController.dataDisplayManager = [self dataDisplayManager];
    viewController.output = presenter;
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
