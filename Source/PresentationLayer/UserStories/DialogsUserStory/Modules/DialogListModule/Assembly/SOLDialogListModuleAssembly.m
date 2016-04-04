//
//  DialogListModuleAssembly.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogListModuleAssembly.h"
#import "SOLDialogListTableViewController.h"

#import "SOLDialogListPresenter.h"
#import "SOLDialogListInteractor.h"
#import "SOLDialogListRouter.h"

@interface SOLDialogListModuleAssembly ()
@property (weak, nonatomic) IBOutlet SOLDialogListTableViewController *viewController;
@end

@implementation SOLDialogListModuleAssembly

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureModuleForViewInput:_viewController];
}

- (void)configureModuleForViewInput:(SOLDialogListTableViewController *)viewInput {
    
    if(viewInput != nil) {
        
        [self configure:viewInput];
    }
}

- (void)configure:(SOLDialogListTableViewController *)viewController {
    
    SOLDialogListRouter *router = [[SOLDialogListRouter alloc] init];
    SOLDialogListPresenter *presenter = [[SOLDialogListPresenter alloc] init];
    SOLDialogListInteractor *interactor = [[SOLDialogListInteractor alloc] init];
    
    interactor.output = presenter;
    presenter.interactor = interactor;
    presenter.router = router;
    presenter.view = viewController;
    viewController.output = presenter;
}

@end
