//
//  NSString+BTUtils.h
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

#import <UIKit/UIKit.h>

#ifdef __IPHONE_6_0
    #define UILineBreakModeWordWrap NSLineBreakByWordWrapping
#endif

@interface NSString (BTUtils)

/** Decode all HTML entities using GTM. */
- (NSString *)stringByDecodingHTMLEntities;

/** Encode all HTML entities using GTM */
- (NSString *)stringByEncodingHTMLEntities;

/** Strip HTML tags from HTML string to plain text. */
- (NSString *)stringByConvertingHTMLToPlainText;

/**
 Get index of character within string.
 @param string A string to get position index from.
 */
- (NSUInteger)indexOf:(NSString *)string;

/** Returns YES if substring is part of string. */
- (BOOL)containsString:(NSString *)substring;

/** Returns url encoded string. */
- (NSString *)urlEncode;

/** Trims leading and trailing whitespace and newline characters from a given string. */
- (NSString *)trim;

/** Creates an NSData object containing the base64 decoded representation of the base64 string. */
- (NSData *)dataFromBase64String;

/** Returns UTF8 hexadecimal representation of string. */
- (NSString *)hexValue;

/**
 Adds new param with value to the existing url with correct formatting.
 @param param A url path parameter.
 @param value A url path value.
 */
- (NSString *)addUrlParam:(NSString *)param withValue:(NSString *)value;

/**
 Returns text bounds size for specified text in predicted field.
 @param text A text to calculate bounds from.
 @param font A font to apply to text.
 @param size A bounds field size.
 */
- (CGSize)textSizeWithFont:(UIFont *)font fieldSize:(CGSize)size;

/** Returns BOOL whenever email is valid or not. */
- (BOOL)isEmailValid;

/** Returns BOOL whenever URL is valid or not. */
- (BOOL)isURLValid;



#pragma mark - Crypto
/** MD5 crypto hash. */
- (NSString *)MD5;

/** SHA1 crypto hash. */
- (NSString *)SHA1;

@end
