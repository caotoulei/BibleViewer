
//  LZMasterViewController.m
//  BibleViewer
//
//  Created by Lei Zhang on 4/9/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//
#import "Parser.h"
#import "Book.h"
#import "LZMasterViewController.h"
#import "LZDetailViewController.h"

@interface LZMasterViewController () {
    NSMutableArray *_objects;
    NSMutableArray *mybooleans;
    NSMutableArray *bookArray;
    NSString *bookAndCh;
}
@end

@implementation LZMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
    Parser *parser = [[Parser alloc] init];
    bookArray = parser->bookArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (LZDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
    
    mybooleans = [[NSMutableArray alloc] init];
    for (int i=0; i<[bookArray count]; i=i+1) {
        //[mybooleans addObject: NO];
        [mybooleans addObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [bookArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(mybooleans[section]==[NSNumber numberWithBool:YES]) {
        ///we want the number of people plus the header cell
        //return 4;
        //Book *b =(Book *)(bookArray[section]);
        //int i = [((Book *)(bookArray[section])).numberOfChapters intValue];
        //this is old version for using cells
        //return [((Book *)(bookArray[section])).numberOfChapters intValue]+1;
        return 2;
    } else {
        ///we just want the header cell
        return 1;
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //For each section, you must return here it's label
    
    return ((Book *)bookArray[section]).name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(indexPath.row==0){
        cell.textLabel.text = @"";
    }
    
    if(indexPath.row==1){
        cell.textLabel.text = @"";
        if(mybooleans[indexPath.section]==[NSNumber numberWithBool:NO]) {
            
            
        }
        if(mybooleans[indexPath.section]==[NSNumber numberWithBool:YES]) {
            
            
            //dynamiclly add chapter button to each book section
            int chNum = [((Book *)bookArray[indexPath.section]).numberOfChapters intValue];
            for (int i=0; i<chNum; i=i+1) {
                int x =(i%10);
                int y =(i-x)/10;
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button1.frame = CGRectMake(x*30.0f, y*30.0f, 30.0f, 30.0f);
                [button1 setTitle: [NSString stringWithFormat:@"%i", i+1] forState:UIControlStateNormal];
                [button1 setTag:indexPath.section]; //set section(book) on button's tag
                [cell addSubview:button1];
                [button1 addTarget:self action:@selector(loadDetail:)  forControlEvents:UIControlEventTouchUpInside];
            }
            
        }
    }
    //else{cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 30;
    }
    if(mybooleans[indexPath.section]==[NSNumber numberWithBool:YES]){
        int chNum = [((Book *)bookArray[indexPath.section]).numberOfChapters intValue];
        return 35.0f + chNum/10 * 30.0f;
    }
    else return 30;
}

- (void)loadDetail: (UIButton *)sender
{
    //NSLog(@"Gooooing to content detail");
    //NSLog([NSString stringWithFormat:@"%i", [sender tag]]);
    //NSLog([(UIButton *)sender currentTitle]);
    self.detailViewController.detailItem = [NSString stringWithFormat:@"%i,%@",
                                            [sender tag],
                                            [(UIButton *)sender currentTitle] ];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ///it's the first row of any section so it would be your custom section header
        
        ///put in your code to toggle your boolean value here
        //mybooleans[indexPath.section] = !mybooleans[indexPath.section];
        if(mybooleans[indexPath.section]==[NSNumber numberWithBool:YES]){
            NSNumber *newValue = [NSNumber numberWithBool:NO];
            [mybooleans replaceObjectAtIndex:indexPath.section withObject:newValue];
            
            
        }
        else if(mybooleans[indexPath.section]==[NSNumber numberWithBool:NO]){
            NSNumber *newValue = [NSNumber numberWithBool:YES];
            [mybooleans replaceObjectAtIndex:indexPath.section withObject:newValue];
            
        }
        ///reload this section
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
    //    NSString *ch = [NSString stringWithFormat:@"%i,%i",[indexPath section], indexPath.row];
    //    if(indexPath.row!=0)
    //        self.detailViewController.detailItem = ch;
    
}


@end