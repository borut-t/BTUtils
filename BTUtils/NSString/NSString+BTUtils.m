//
//  NSString+BTUtils.m
//
//  Version 1.3.10
//
//  Created by Borut Tomazin on 8/30/2013.
//  Copyright 2015 Borut Tomazin
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/borut-t/BTUtils
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "NSString+BTUtils.h"
#import "GTMNSString+HTML.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#define BINARY_UNIT_SIZE 3
#define BASE64_UNIT_SIZE 4
#define xx 65

//static unsigned char base64EncodeLookup[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

//
// Mapping from ASCII character to 6 bit pattern.
//
static unsigned char base64DecodeLookup[256] =
{
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
    xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
    xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
};

//
// NewBase64Decode
//
// Decodes the base64 ASCII string in the inputBuffer to a newly malloced
// output buffer.
//
//  inputBuffer - the source ASCII string for the decode
//	length - the length of the string or -1 (to specify strlen should be used)
//	outputLength - if not-NULL, on output will contain the decoded length
//
// returns the decoded buffer. Must be free'd by caller. Length is given by
//	outputLength.
//
void *NewBase64Decode(const char *inputBuffer, size_t length, size_t *outputLength)
{
	if (length == -1) {
		length = strlen(inputBuffer);
	}
	
	size_t outputBufferSize =
    ((length+BASE64_UNIT_SIZE-1) / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE;
	unsigned char *outputBuffer = (unsigned char *)malloc(outputBufferSize);
	
	size_t i = 0;
	size_t j = 0;
	while (i < length) {
		//
		// Accumulate 4 valid characters (ignore everything else)
		//
		unsigned char accumulated[BASE64_UNIT_SIZE];
		size_t accumulateIndex = 0;
		while (i < length) {
			unsigned char decode = base64DecodeLookup[inputBuffer[i++]];
			if (decode != xx) {
				accumulated[accumulateIndex] = decode;
				accumulateIndex++;
				
				if (accumulateIndex == BASE64_UNIT_SIZE) {
					break;
				}
			}
		}
		
		//
		// Store the 6 bits from each of the 4 characters as 3 bytes
		//
		// (Uses improved bounds checking suggested by Alexandre Colucci)
		//
		if(accumulateIndex >= 2)
			outputBuffer[j] = (accumulated[0] << 2) | (accumulated[1] >> 4);
		if(accumulateIndex >= 3)
			outputBuffer[j + 1] = (accumulated[1] << 4) | (accumulated[2] >> 2);
		if(accumulateIndex >= 4)
			outputBuffer[j + 2] = (accumulated[2] << 6) | accumulated[3];
		j += accumulateIndex - 1;
	}
	
	if (outputLength) {
		*outputLength = j;
	}
	return outputBuffer;
}

@implementation NSString (BTUtils)

- (NSString *)stringByDecodingHTMLEntities
{
	return [NSString stringWithString:[self gtm_stringByUnescapingFromHTML]]; 
}

- (NSString *)stringByEncodingHTMLEntities
{
	return [NSString stringWithString:[self gtm_stringByEscapingForAsciiHTML]];
}

- (NSString *)stringByConvertingHTMLToPlainText
{
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *output = self;
    theScanner = [NSScanner scannerWithString:output];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        output = [output stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    output = [[output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByDecodingHTMLEntities];
    
    return output;
}

- (NSUInteger)indexOf:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return range.location;
}

- (BOOL)containsString:(NSString *)substring
{
    return [self rangeOfString:substring].location != NSNotFound;
}

- (NSString *)urlEncode
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge_retained CFStringRef)self,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSData *)dataFromBase64String
{
//    if ([self respondsToSelector:@selector(base64EncodedDataWithOptions:)]) {
//        return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    }
    
	NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding];
	size_t outputLength;
	void *outputBuffer = NewBase64Decode([data bytes], [data length], &outputLength);
	NSData *result = [NSData dataWithBytes:outputBuffer length:outputLength];
	free(outputBuffer);
	return result;
}

- (NSString *)hexValue
{
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i=0; i<len; i++) {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    
    free(chars);
    
    return hexString;
}

- (NSString *)addUrlParam:(NSString *)param withValue:(NSString *)value
{
    NSString *pathSpecifier = @"?";
    if ([self rangeOfString:@"?" options:(NSCaseInsensitiveSearch)].location != NSNotFound) {
        pathSpecifier = @"&";
    }
    return [self stringByAppendingFormat:@"%@%@=%@",pathSpecifier,param,value];
}

- (CGSize)textSizeWithFont:(UIFont *)font fieldSize:(CGSize)size;
{
    if (self == nil || [self trim].length == 0 || !font) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGSize boundingBox = [self boundingRectWithSize:size
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:font}
                                                context:nil].size;
        return CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else {
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        #pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

- (BOOL)isEmailValid
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"] evaluateWithObject:self];
}

- (BOOL)isURLValid
{
    NSString *urlPredicate = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlPredicate];
    return [urlTest evaluateWithObject:self];
}



#pragma mark - Crypto
- (NSString *)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (unsigned int)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)SHA1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
