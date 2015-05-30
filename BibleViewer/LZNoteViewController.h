//
//  LZNoteViewController.h
//  BibleViewer
//
//  Created by Lei Zhang on 12/10/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZAppDelegate.h"
#import <CoreData/CoreData.h>

@interface LZNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *noteSaveButton;

@property  NSInteger *numCh;
@property  NSInteger *numBook;

- (IBAction)saveNote:(id)sender;
- (IBAction)loadNote:(id)sender;

- (IBAction)updateNote:(id)sender;

@end
