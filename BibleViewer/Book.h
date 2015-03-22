//
//  Book.h
//  BibleViewer
//
//  Created by Lei Zhang on 8/21/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
{
    NSNumber *bookId;
    NSString *name;
    NSString *numberOfChapters;
}

@property(nonatomic, retain) NSNumber *bookId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *numberOfChapters;

@end