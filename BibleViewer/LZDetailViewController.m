//
//  LZDetailViewController.m
//  BibleViewer
//
//  Created by Lei Zhang on 4/7/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import "LZDetailViewController.h"
#import "BibleXMLParser.h"
#import "LZNoteViewController.h"
#import "Parser.h"

@interface LZDetailViewController ()
{
    NSMutableArray *bookArray;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation LZDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        int bookNumber = [[[self.detailItem description] componentsSeparatedByString:@","][0] integerValue]+1;
        int chapterNumber = [[[self.detailItem description] componentsSeparatedByString:@","][1] integerValue];
        
        //BibleXMLParser *parser = [[BibleXMLParser alloc] init];
        BibleXMLParser *parser = [[BibleXMLParser alloc] initWithQuery: bookNumber:chapterNumber:1];
        //self.detailDescriptionLabel.text = parser->content;
        [self.contentWebView loadHTMLString:[parser->content description] baseURL:nil];
        
        [self configureView];
        
        Parser *indexparser = [[Parser alloc] init];
        bookArray = indexparser->bookArray;
        self.title =[NSString stringWithFormat:@"%@%i", [((Book *)bookArray[bookNumber-1]).name stringByReplacingOccurrencesOfString: @"\n" withString:@""],  chapterNumber];
        
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
       
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(IBAction) clickAddNoteButton:(id)sender{
    //add note code here
    NSLog(@"Add note;");
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showNoteSegue"]){
//        ViewControllerB *controller = (ViewControllerB *)segue.destinationViewController;
//        controller.isSomethingEnabled = YES;
       LZNoteViewController *noteViewController = (LZNoteViewController *)segue.destinationViewController;
        
    int bookNumber = [[[self.detailItem description] componentsSeparatedByString:@","][0] integerValue]+1;
    int chapterNumber = [[[self.detailItem description] componentsSeparatedByString:@","][1] integerValue];
        
    noteViewController.numBook = bookNumber;
    noteViewController.numCh = chapterNumber;
        
    }
}

@end
