//
//  NSString+_.m
//  Convolounge
//
//  Created by Pro on 4/15/15.
//  Copyright (c) 2015 Pro. All rights reserved.
//

#import "NSString+_.h"

static char *alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";


@implementation NSString (_)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    CGFloat sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)urlDecode{

    NSString *decoded = [self stringByRemovingPercentEncoding];
    return decoded;
}

-(NSString *)ASCIIencode {
    
    NSData *authData = [self dataUsingEncoding:NSASCIIStringEncoding];
    
    CGFloat encodedLength = (((([authData length] % 3) + [authData length]) / 3) * 4) + 1;
     char *outputBuffer = malloc(encodedLength);
    unsigned char *inputBuffer = (unsigned char *)[authData bytes];
    
    NSInteger i;
    NSInteger j = 0;
    CGFloat remain;
    
    for(i = 0; i < [authData length]; i += 3) {
        remain = [authData length] - i;
        
        outputBuffer[j++] = alphabet[(inputBuffer[i] & 0xFC) >> 2];
        outputBuffer[j++] = alphabet[((inputBuffer[i] & 0x03) << 4) |
                                     ((remain > 1) ? ((inputBuffer[i + 1] & 0xF0) >> 4): 0)];
        
        if(remain > 1)
            outputBuffer[j++] = alphabet[((inputBuffer[i + 1] & 0x0F) << 2)
                                         | ((remain > 2) ? ((inputBuffer[i + 2] & 0xC0) >> 6) : 0)];
        else
            outputBuffer[j++] = '=';
        
        if(remain > 2)
            outputBuffer[j++] = alphabet[inputBuffer[i + 2] & 0x3F];
        else
            outputBuffer[j++] = '=';
    }
    
    outputBuffer[j] = 0;
    
    NSString *result = [NSString stringWithCString:outputBuffer encoding:NSASCIIStringEncoding];
//    NSString *result = [NSString stringWithCString:outputBuffer length:strlen(outputBuffer)];
    free(outputBuffer);
    
    return result;
}

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

- (UIImage *)decodeBase64ToImage{
    
    NSData *tmpData = [self base64DataFromString];
    //    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:0];
    return [UIImage imageWithData:tmpData];
}

- (NSData *)base64DataFromString
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (self == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[self UTF8String];
    
    lentext = [self length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    return theData;
}

+(CGFloat)heightOfTextForString:(NSString *)text andLable:(UILabel *)myLabel
{
    // iOS7
    
    return  [self heightOfTextForString:text size:myLabel.frame.size font:myLabel.font];
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(myLabel.frame.size.width, CGFLOAT_MAX)
//                                             options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
//                                          attributes:@{NSFontAttributeName: myLabel.font}
//                                             context:nil];
//    rect.size.width = ceil(rect.size.width);
//    rect.size.height = ceil(rect.size.height);
//    return rect.size.height;
}

+(CGFloat)heightOfTextForString:(NSString *)text size:(CGSize)size font:(UIFont *)font
{
    // iOS7
    CGRect rect = [text boundingRectWithSize:CGSizeMake(size.width, CGFLOAT_MAX)
                                     options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    rect.size.width = ceil(rect.size.width);
    rect.size.height = ceil(rect.size.height);
    return rect.size.height;
}

- (NSString *)getLastCharacter{

    NSString *str = @"";
    if(self.length > 0)
        str = [self substringFromIndex:self.length-1];
    else
        str = [self substringFromIndex:self.length];
    return str;
}

- (NSString *)removeLastCharacter{

    NSString *str = @"";
    if(self.length)
      str  = [self substringToIndex:[self length]-1];
    
    return str;
}

- (NSString *)getLastSpaceSepString{

    NSArray *strArray = [self componentsSeparatedByString:@" "];
    
    if(strArray.count)
        return [strArray lastObject];
    else
        return nil;
}

//+ (NSInteger)linesForString:(NSString *)string andLable:(UILabel *)myLabel size:(CGSize)size{
//
//    UIFont *font = [UIFont boldSystemFontOfSize:11.0];
//    CGSize tmpSize = [string sizeWithFont:font
//                     constrainedToSize:size
//                         lineBreakMode:UILineBreakModeWordWrap]; // default mode
//    float numberOfLines = tmpSize.height / font.lineHeight;
//    return numberOfLines;
//}

@end
