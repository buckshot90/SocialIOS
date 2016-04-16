//
//  POOInvaitsViewController.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 14.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POOInvaitsViewController : UIViewController

@property (strong, nonatomic) NSArray *invites;

- (void)reloadData;

@end
