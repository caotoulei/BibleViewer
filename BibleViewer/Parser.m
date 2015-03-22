//
//  Parser.m
//  BibleViewer
//
//  Created by Lei Zhang on 8/20/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import "Parser.h"
#import "Book.h"

 NSMutableArray *bookArray;
 Book *book;
 int bookIndex;
@implementation Parser

-init {
    if(self == [super init]) {
        
        bookArray = [[NSMutableArray alloc] initWithCapacity: 66];
        for (int i=0; i<66; i=i+1) {
            Book *b = [[Book alloc] init];
            [bookArray addObject:b];
        }
        parser = [[NSXMLParser alloc]
                  initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bible" ofType: @"xml"]]];
        [parser setDelegate:self];
        [parser parse];
    }      
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    NSLog(@"Started Element %@", elementName);
    element = [NSMutableString string];
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    NSLog(@"Found an element named: %@ with a value of: %@", elementName, element);
    
    if ([elementName isEqual:@"Id"]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * idNumber = [f numberFromString:element];
        bookIndex =[idNumber intValue]-1;
        Book *b = [bookArray objectAtIndex:bookIndex];
        b.bookId =idNumber;
    }
    if ([elementName isEqual:@"Title"]) {
        Book *b = [bookArray objectAtIndex:bookIndex];
        b.name  = element;
    }
    if ([elementName isEqual:@"ChapterNum"]) {
        Book *b = [bookArray objectAtIndex:bookIndex];
        b.numberOfChapters = element;
    }
    if ([elementName isEqual:@"book"]) {
        
        
    }
    
    
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
if(element == nil)
    element = [[NSMutableString alloc] init];
[element appendString:string];

}



@end
