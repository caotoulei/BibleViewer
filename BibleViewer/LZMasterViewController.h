//
//  LZMasterViewController.h
//  BibleViewer
//
//  Created by Lei Zhang on 4/7/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZDetailViewController;

@interface LZMasterViewController : UITableViewController

@property (strong, nonatomic) LZDetailViewController *detailViewController;

@end
