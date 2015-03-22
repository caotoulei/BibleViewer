//
//  LZNoteViewController.m
//  BibleViewer
//
//  Created by Lei Zhang on 12/10/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import "LZNoteViewController.h"
#import <CoreData/CoreData.h>

@interface LZNoteViewController ()

@end

@implementation LZNoteViewController

- (void)viewDidLoad {
    _titleLabel.text = [NSString stringWithFormat: @"Add Note for this chapter%d %d", self.numBook, self.numCh];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveNote:(id)sender {
    _titleLabel.text = @"Add Note for this chapter...";
    LZAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newNote;
    newNote = [NSEntityDescription
                  insertNewObjectForEntityForName: @"BibleNote"
                  inManagedObjectContext:context];
    [newNote setValue: [NSDate date] forKey:@"addedOn"];
    [newNote setValue: @"Lei Zhang" forKey:@"addedBy"];
    NSNumber *myNumber = [NSNumber numberWithInt:1];
    [newNote setValue: myNumber forKey:@"bookNumber"];
    [newNote setValue: myNumber forKey:@"chapterNumber"];
    [newNote setValue: @"test project" forKey:@"content"];

    NSError *error;
    [context save:&error];
}

-(IBAction)loadNote:(id)sender{
    LZAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"BibleNote"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(addedBy = %@)",
     @"Lei Zhang" ];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _noteContentTextView.text = @"No matches";
    } else {
        matches = objects[0];
        _noteContentTextView.text = [matches valueForKey:@"content"];
    }
}



@end
