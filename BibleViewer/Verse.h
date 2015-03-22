//
//  Verse.h
//  BibleViewer
//
//  Created by Lei Zhang on 9/16/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Verse : NSObject
{
    
    NSString *number;
    NSString *content;
}

@property(nonatomic, retain) NSString *number;
@property(nonatomic, retain) NSString *content;

@end
