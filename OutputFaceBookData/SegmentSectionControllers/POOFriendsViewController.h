//
//  POOFriendsViewController.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 13.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POOFriendsViewController : UIViewController

@property (strong, nonatomic) NSArray *friends;

- (void)reloadData;

@end
