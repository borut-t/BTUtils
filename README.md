## Purpose
Usable utility methods, categories, macros and helpers to speed up your iOS development.


### Changelog (v1.4.11)
- Fixed border width in method imageWithBorderWidth:inColor:.


### Installation
Just add `pod ‘BTUtils’` to your Podfile or drag class files into your project.


### ARC Support
BTUtils fully supports ARC.


### Supported OS
iOS 5+


## Macros
	RGB(r, g, b)

UIColor on-liner for native colorWithRed method without alpha.

	RGBA(r, g, b, a)

UIColor on-liner for native colorWithRed method with alpha.

	SYSTEM_VERSION_GREATER_OR_EQUAL_TO(v)

Checks if system version is greater than or equal to specific string version.

    DEVICE_SIZE

Return actual physical device size.

    RADIANS_TO_DEGREES(radians)

Converts radians to degrees.

    DEGREES_TO_RADIANS(angle)

Converts degrees to radians.

    IS_NOT_NULL(dictionary, key)

Checks if given key exists in given dict.

    IS_ARRAY(array)

Checks if given array is array.

    IS_DICTIONARY(dict)

Checks if given dictionary is dictionary.

    IS_EMPTY(string)

Checks if given string is nil or zero length.

	BSLog(format, …)

Drop-in replacement for standard NSLog with much nicer console output.


## Methods
### Device
	+ (NSString *)OSVersion;

Returns the current version of the operating system.

	+ (NSString *)appVersion;

Returns app version string using key 'CFBundleShortVersionString'.

	+ (NSString *)appBuild;

Returns app build string using key 'CFBundleVersion'.

    + (NSString *)appName;

Returns app name string using key 'CFBundleDisplayName'.

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

    + (PhoneScreenSize)phoneScreenSize;

Returns iPhone screen size.

	+ (BOOL)isPhone4Inch; -deprecated

Returns YES if device is phone and 4inch (a.k.a. iPhone 5/5s/5c).

	+ (BOOL)isRetina;

Returns YES if device screen has retina resolution.

	+ (NSString *)CFUUID;

Returns the string representation of a specified CFUUID object.


### Network
	+ (void)showNetworkLoader:(BOOL)show;

Toggles network activity indicator.

	+ (NSString *)resourcePath:(NSString *)name;

Returns resource path for selected file name.

	+ (NSString *)appStoreLinkForAppId:(NSString *)appId;

Returns App Store link for selected appId.

	+ (NSString *)urlEncodedString:(NSString *)string;

Url encodes string.


### Other
    + (NSArray *)traceCallStack;

Call this private instance method from the class you want to trace stack.

    + (NSString *)traceCallClassWithDetails:(BOOL)withDetails;

Call this private instance method from the class you want to trace class.

    + (NSArray *)propertyNamesForObject:(id)object;

Returns class property names.


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

	- (BOOL)containsString:(NSString *)substring;

Returns YES if substring is part of string.

	- (NSString *)urlEncode;

Returns url encoded string.

	- (NSString *)trim;

Trims leading and trailing whitespace and newline characters from a given string.

	- (NSData *)dataFromBase64String;

Creates an NSData object containing the base64 decoded representation of the base64 string.

	- (NSString *)hexValue;

Returns UTF8 hexadecimal representation of string.

	- (NSString *)addUrlParam:(NSString *)param withValue:(NSString *)value;

Adds new param with value to the existing url with correct formatting.

	- (NSString *)MD5;

MD5 crypto hash.

	- (NSString *)SHA1;

SHA1 crypto hash.

	- (CGSize)textSizeWithFont:(UIFont *)font fieldSize:(CGSize)size;

Returns text bounds size for specified text in predicted field.

	- (BOOL)isEmailValid;

Returns BOOL whenever email is valid or not.

    - (BOOL)isURLValid;

Returns BOOL whenever URL is valid or not.


### NSData
	- (NSString *)base64EncodedString;

Creates an NSString object that contains the base 64 encoding of the receiver's data. Lines are broken at 64 characters long.


### UIImage
    - (UIImage *)imageWithBorderWidth:(CGFloat)borderWidth inColor:(UIColor *)borderColor

Returns image with rounded corners and border color.

	- (UIImage *)imageWithRoundedCornersRadius:(float)radius andBorderColor:(UIColor *)borderColor;

Returns image with rounded corners and border color.

	- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

Returns scaled image for target size.

	- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

Returns image with given opacity.

	- (UIImage *)imageWithShadowSize:(CGFloat)size shadowColor:(UIColor *)color;

Returns given image with shadow.


### UIView
	- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

Returns masked view with rounded corners.

    - (void)pulseEffectToSize:(CGFloat)size duration:(CGFloat)duration;

Add pulse animation to view.

    - (void)spinWithDuration:(CFTimeInterval)duration angle:(CGFloat)angle;

Spin view's layer.

    - (void)dashedLineWithColor:(UIColor *)color;

Returns dashed line/view.

	- (CGSize)size;

Gets frame size.

	- (void)setSize:(CGSize)size;

Sets frame size.

	- (CGFloat)width;

Gets frame width.

	- (void)setWidth:(CGFloat)width;

Sets frame width.

	- (CGFloat)height;

Gets frame height.

	- (void)setHeight:(CGFloat)height;

Sets frame height.

	- (CGFloat)x;

Gets frame x origin.

	- (void)setX:(CGFloat)originX;

Sets frame x origin.

	- (CGFloat)y;

Gets frame y origin.

	- (void)setY:(CGFloat)originY;

Sets frame y origin.

    static inline CGFloat CGHorizontalCenterInParent(CGRect frame, CGFloat childWidth)

Returns horizontally centered x coordinate for given child width in parent frame.

    static inline CGFloat CGVerticalCenterInParent(CGRect frame, CGFloat childHeight)

Returns vertically centered y coordinate for given child height in parent frame.

    static inline CGRect CGCenterInParent(CGRect parent, CGFloat childWidth, CGFloat childHeight)

Returns centered frame for given child width and height in parent frame.


### NSArray
    - (NSArray *)reversedArray;

Reverses array values.


### UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString;

Returns color for given from hex color format.


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
