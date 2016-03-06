//
//  NSString+_.h
//

//
//  Created by Pro on 4/15/15.
//  Copyright (c) 2015 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (_)


- (NSString *)urlencode;
- (NSString *)urlDecode;

-(NSString *)ASCIIencode;
- (BOOL)myContainsString:(NSString*)other;


- (NSData *)base64DataFromString;

- (NSString *)getLastCharacter;
- (NSString *)removeLastCharacter;
- (NSString *)getLastSpaceSepString;
@end
