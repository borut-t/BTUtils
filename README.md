## Purpose
Usable utility methods, categories, macros and helpers to speed up your iOS development.


## ARC Support
BTBadgeView fully supports ARC.


## Installation
Add `pod ‘BTUtils’` to your Podfile or drag class files into your project.


## Macros
	RGB(r, g, b)

UIColor on-liner for native colorWithRed method with without alpha.

	RGBA(r, g, b, a)

UIColor on-liner for native colorWithRed method with specified alpha.

	SYSTEM_VERSION_GREATER_OR_EQUAL_TO(v)

Check if system version is greater than or equal to specific string version.

	BSLog(format, …)

Drop-in replacement for standard NSLog.


## Methods
### Device
	+ (NSString *)OSVersion;

Returns the current version of the operating system.

	+ (NSString *)appVersion;

Returns app version string using key 'CFBundleShortVersionString'.

	+ (NSString *)appBuild;

Returns app build string using key 'CFBundleVersion'.

	+ (NSString *)deviceModel;

Returns device model.

	+ (CGSize)screenSize;

Returns screen size.

	+ (UIInterfaceOrientation)orientation;

Returns interface orienation.

	+ (BOOL)isPad;

Returns YES when UIUserInterfaceIdiom is Pad.

	+ (BOOL)isPhone;

Returns YES when UIUserInterfaceIdiom is Phone.

	+ (BOOL)isPhone4Inch;

Returns YES if device is phone and 4inch (a.k.a. iPhone 5/5s/5c).

	+ (BOOL)isRetina;

Returns YES if device screen has retina resolution.

	+ (NSString *)CFUUID;

Returns the string representation of a specified CFUUID object.


### Network
	+ (void)showNetworkLoader:(BOOL)show;

Toggles network activity indicator.

	+ (BOOL)isReachable;

Returns status of the internet connection using Reachability class.

	+ (NSString *)resourcePath:(NSString *)name;

Returns resource path for selected file name.

	+ (NSString *)appStoreLinkForAppId:(NSString *)appId;

Returns App Store link for selected appId.

	+ (NSString *)urlEncodedString:(NSString *)string;

Url encodes string.


### Image
	+ (UIImage *)imageNamed:(NSString *)name;

Returns uncached image from filesystem.

	+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

Generates new UIImage for selected color and size.

	+ (UIImage *)captureView:(UIView *)view;

Captures screen for selected view.

	+ (UIImage *)captureFrame:(CGRect)frame inView:(UIView *)view;

Captures frame inside selected view.


## Categories
### NSString
	- (NSString *)stringByDecodingHTMLEntities;

Decode all HTML entities using GTM.

	- (NSString *)stringByEncodingHTMLEntities;

Encode all HTML entities using GTM

	- (NSString *)stringByConvertingHTMLToPlainText;

Strip HTML tags from HTML string to plain text.

	- (NSUInteger)indexOf:(NSString *)character;

Get index of character within string.

	- (NSString *)urlEncode;

Returns url encoded string.

	- (NSString *)trim;

Trims leading and trailing whitespaces from given string.

	- (NSData *)dataFromBase64String;

Creates an NSData object containing the base64 decoded representation of the base64 string.

	- (NSString *)addUrlParam:(NSString *)param withValue:(NSString *)value;

Adds new param with value to the existing url with correct formatting.

	- (NSString *)MD5;

MD5 crypto hash.

	- (NSString *)SHA1;

SHA1 crypto hash.

	- (CGSize)textSizeWithFont:(UIFont *)font fieldSize:(CGSize)size;

Returns text bounds size for specified text in predicted field.

	- (BOOL)isEmailValid;

Returns boolean whenever email is valid or not.


### NSData
	- (NSString *)base64EncodedString;

Creates an NSString object that contains the base 64 encoding of the receiver's data. Lines are broken at 64 characters long.


### UIImage
	- (UIImage *)imageWithRoundedCornersRadius:(float)radius andBorderColor:(UIColor *)borderColor;

Returns image with rounded corners and border color.

	- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

Returns scaled image for target size.

	- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

Returns image with given opacity.


### UIView
	- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

Returns masked view with rounded corners.

	- (CGSize)size;

Returns view frame size.

	- (void)setSize:(CGSize)size;

Sets view frame size.


### UITabBarController
	- (void)showTabBarAnimated:(BOOL)animated;

Shows tabBar with/without animation.

	- (void)hideTabBarAnimated:(BOOL)animated;

Hides tabBar with/without animation.


## Helpers
### UINavigationController
	- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

	- (BOOL)shouldAutorotate

	- (NSUInteger)supportedInterfaceOrientations


### UITabBarController
	- (BOOL)shouldAutorotate

	- (NSUInteger)supportedInterfaceOrientations

	- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation