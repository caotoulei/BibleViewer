//
//  BibleXMLParser.h
//  BibleViewer
//
//  Created by Lei Zhang on 9/10/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Verse.h"

@interface BibleXMLParser : NSObject<NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableString *element;

    @public Verse *verse;
    @public NSString *content;
    
}

- (BibleXMLParser *) initWithQuery:(int)query_book:(int)query_chapter:(int)query_verse;
@end
