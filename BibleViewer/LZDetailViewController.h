//
//  LZDetailViewController.h
//  BibleViewer
//
//  Created by Lei Zhang on 4/7/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;


-(IBAction) clickAddNoteButton:(id)sender;

@end
