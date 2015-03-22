//
//  Parser.h
//  BibleViewer
//
//  Created by Lei Zhang on 8/20/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface Parser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableString *element;
    
    @public NSMutableArray *bookArray;
    @public Book *book;
}

@end