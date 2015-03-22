//
//  BibleXMLParser.m
//  BibleViewer
//
//  Created by Lei Zhang on 9/10/14.
//  Copyright (c) 2014 Lei Zhang. All rights reserved.
//

#import "BibleXMLParser.h"
#import "Verse.h"


int bIndex;
int cIndex;
int vIndex;
int queryBookIndex;
int queryChapterIndex;
int queryVerseIndex;

@implementation BibleXMLParser

-init {
    if(self == [super init]) {
    
        content=@"";
        
        parser = [[NSXMLParser alloc]
                  initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cuvt_asv.utf8" ofType: @"xml"]]];
        [parser setDelegate:self];
        [parser parse];
    }
    return self;
}

- (BibleXMLParser *)initWithQuery:(int)query_book:(int)query_chapter:(int)query_verse{
    
    queryBookIndex = query_book;
    queryChapterIndex = query_chapter;
    queryVerseIndex = query_verse;
    self = [self init];

    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    //NSLog(@"Started Element %@", elementName);
    element = [NSMutableString string];
    
    if ([elementName isEqual:@"book"]){
        bIndex = [[attributeDict objectForKey:@"id"] integerValue];
    }
    if ([elementName isEqual:@"chapter"]){
        cIndex = [[attributeDict objectForKey:@"id"] integerValue];
    }
    if ([elementName isEqual:@"verse"]){
        vIndex = [[attributeDict objectForKey:@"id"] integerValue];
    }
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    //NSLog(@"Found an element named: %@ with a value of: %@", elementName, element);
   
    if ([elementName isEqual:@"verse"]
        && bIndex==queryBookIndex
        && cIndex==queryChapterIndex  //&& vIndex == queryVerseIndex
        ) {
      
        content= [NSString stringWithFormat:@"%@/ %d %@<br/>", content, vIndex, element];
        
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:."];
        content = [[content componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
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
