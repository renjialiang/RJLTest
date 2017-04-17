//
//  EQAttributedLabel.m
//  testLayout
//
//  Created by renjialiang on 15/12/23.
//  Copyright © 2015年 renjialiang. All rights reserved.
//

#import "EQAttributedLabel.h"

#define kEQLineBreakWordWrapTextWidthScalingFactor (M_PI / M_E)

NSString * const kEQStrikeOutAttributeName = @"StrikeOutAttribute";
NSString * const kStrikeOutAttributeName = @"StrikeOutAttribute";
NSString * const kBackgroundFillColorAttributeName = @"BackgroundFillColor";
NSString * const kBackgroundFillPaddingAttributeName = @"BackgroundFillPadding";
NSString * const kBackgroundStrokeColorAttributeName = @"BackgroundStrokeColor";
NSString * const kBackgroundLineWidthAttributeName = @"BackgroundLineWidth";
NSString * const kBackgroundCornerRadiusAttributeName = @"BackgroundCornerRadius";
static inline CGFloat EQTFlushFactorForTextAlignment(NSTextAlignment textAlignment) {
	switch (textAlignment) {
		case NSTextAlignmentCenter:
			return 0.5f;
		case NSTextAlignmentRight:
			return 1.0f;
		case NSTextAlignmentLeft:
		default:
			return 0.0f;
	}
}

static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return ceil(cgfloat);
#else
	return ceilf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_floor(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return floor(cgfloat);
#else
	return floorf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_round(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return round(cgfloat);
#else
	return roundf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_sqrt(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return sqrt(cgfloat);
#else
	return sqrtf(cgfloat);
#endif
}

static inline CTTextAlignment CTTextAlignmentFromUITextAlignment(NSTextAlignment alignment) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
	switch (alignment) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
		case NSTextAlignmentLeft: return kCTTextAlignmentLeft;
		case NSTextAlignmentCenter: return kCTTextAlignmentCenter;
		case NSTextAlignmentRight: return kCTTextAlignmentRight;
		default: return kCTTextAlignmentNatural;
#else
		case NSTextAlignmentLeft: return kCTLeftTextAlignment;
		case NSTextAlignmentCenter: return kCTCenterTextAlignment;
		case NSTextAlignmentRight: return kCTRightTextAlignment;
		default: return kCTNaturalTextAlignment;
#endif
	}
#else
	switch (alignment) {
		case UITextAlignmentLeft: return kCTLeftTextAlignment;
		case UITextAlignmentCenter: return kCTCenterTextAlignment;
		case UITextAlignmentRight: return kCTRightTextAlignment;
		default: return kCTNaturalTextAlignment;
	}
#endif
}

static inline CTLineBreakMode CTLineBreakModeFromUILineBreakMode(NSLineBreakMode lineBreakMode) {
	switch (lineBreakMode) {
		case NSLineBreakByWordWrapping: return kCTLineBreakByWordWrapping;
		case NSLineBreakByCharWrapping: return kCTLineBreakByCharWrapping;
		case NSLineBreakByClipping: return kCTLineBreakByClipping;
		case NSLineBreakByTruncatingHead: return kCTLineBreakByTruncatingHead;
		case NSLineBreakByTruncatingTail: return kCTLineBreakByTruncatingTail;
		case NSLineBreakByTruncatingMiddle: return kCTLineBreakByTruncatingMiddle;
		default: return 0;
	}
}

static inline NSDictionary * NSAttributedStringAttributesFromLabel(EQAttributedLabel *label) {
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
	if ([NSMutableParagraphStyle class]) {
		[mutableAttributes setObject:label.font forKey:(NSString *)kCTFontAttributeName];
		[mutableAttributes setObject:label.textColor forKey:(NSString *)kCTForegroundColorAttributeName];
		[mutableAttributes setObject:@(label.kern) forKey:(NSString *)kCTKernAttributeName];
		
		NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
		paragraphStyle.alignment = label.textAlignment;
		paragraphStyle.lineSpacing = label.lineSpacing;
		paragraphStyle.minimumLineHeight = label.minimumLineHeight > 0 ? label.minimumLineHeight : label.font.lineHeight * label.lineHeightMultiple;
		paragraphStyle.maximumLineHeight = label.maximumLineHeight > 0 ? label.maximumLineHeight : label.font.lineHeight * label.lineHeightMultiple;
		paragraphStyle.lineHeightMultiple = label.lineHeightMultiple;
		paragraphStyle.firstLineHeadIndent = label.firstLineIndent;
		
		if (label.numberOfLines == 1) {
			paragraphStyle.lineBreakMode = label.lineBreakMode;
		} else {
			paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
		}
		
		[mutableAttributes setObject:paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
	} else {
		CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)label.font.fontName, label.font.pointSize, NULL);
		[mutableAttributes setObject:(__bridge id)font forKey:(NSString *)kCTFontAttributeName];
		CFRelease(font);
		
		[mutableAttributes setObject:(id)[label.textColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
		[mutableAttributes setObject:@(label.kern) forKey:(NSString *)kCTKernAttributeName];
		
		CTTextAlignment alignment = CTTextAlignmentFromUITextAlignment(label.textAlignment);
		CGFloat lineSpacing = label.lineSpacing;
		CGFloat minimumLineHeight = label.minimumLineHeight * label.lineHeightMultiple;
		CGFloat maximumLineHeight = label.maximumLineHeight * label.lineHeightMultiple;
		CGFloat lineSpacingAdjustment = CGFloat_ceil(label.font.lineHeight - label.font.ascender + label.font.descender);
		CGFloat lineHeightMultiple = label.lineHeightMultiple;
		CGFloat firstLineIndent = label.firstLineIndent;
		
		CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
		if (label.numberOfLines == 1) {
			lineBreakMode = CTLineBreakModeFromUILineBreakMode(label.lineBreakMode);
		}
		
		CTParagraphStyleSetting paragraphStyles[12] = {
			{.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void *)&alignment},
			{.spec = kCTParagraphStyleSpecifierLineBreakMode, .valueSize = sizeof(CTLineBreakMode), .value = (const void *)&lineBreakMode},
			{.spec = kCTParagraphStyleSpecifierLineSpacing, .valueSize = sizeof(CGFloat), .value = (const void *)&lineSpacing},
			{.spec = kCTParagraphStyleSpecifierMinimumLineSpacing, .valueSize = sizeof(CGFloat), .value = (const void *)&minimumLineHeight},
			{.spec = kCTParagraphStyleSpecifierMaximumLineSpacing, .valueSize = sizeof(CGFloat), .value = (const void *)&maximumLineHeight},
			{.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment, .valueSize = sizeof (CGFloat), .value = (const void *)&lineSpacingAdjustment},
			{.spec = kCTParagraphStyleSpecifierLineHeightMultiple, .valueSize = sizeof(CGFloat), .value = (const void *)&lineHeightMultiple},
			{.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent, .valueSize = sizeof(CGFloat), .value = (const void *)&firstLineIndent},
		};
		
		CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphStyles, 12);
		[mutableAttributes setObject:(__bridge id)paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
		CFRelease(paragraphStyle);
	}
	
	return [NSDictionary dictionaryWithDictionary:mutableAttributes];

}

static inline NSAttributedString * NSAttributedStringBySettingColorFromContext(NSAttributedString *attributedString, UIColor *color) {
	if (!color) {
		return attributedString;
	}
	
	NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
	[mutableAttributedString enumerateAttribute:(NSString *)kCTForegroundColorFromContextAttributeName inRange:NSMakeRange(0, [mutableAttributedString length]) options:0 usingBlock:^(id value, NSRange range, __unused BOOL *stop) {
		BOOL usesColorFromContext = [value boolValue];
		if (usesColorFromContext) {
			[mutableAttributedString setAttributes:[NSDictionary dictionaryWithObject:color forKey:(NSString *)kCTForegroundColorAttributeName] range:range];
			[mutableAttributedString removeAttribute:(NSString *)kCTForegroundColorFromContextAttributeName range:range];
		}
	}];
	
	return mutableAttributedString;
}
static inline CGColorRef CGColorRefFromColor(id color) {
	return [color isKindOfClass:[UIColor class]] ? [color CGColor] : (__bridge CGColorRef)color;
}

static inline NSAttributedString * NSAttributedStringByScalingFontSize(NSAttributedString *attributedString, CGFloat scale) {
	NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
	[mutableAttributedString enumerateAttribute:(NSString *)kCTFontAttributeName inRange:NSMakeRange(0, [mutableAttributedString length]) options:0 usingBlock:^(id value, NSRange range, BOOL * __unused stop) {
		UIFont *font = (UIFont *)value;
		if (font) {
			NSString *fontName;
			CGFloat pointSize;
			
			if ([font isKindOfClass:[UIFont class]]) {
				fontName = font.fontName;
				pointSize = font.pointSize;
			} else {
				fontName = (NSString *)CFBridgingRelease(CTFontCopyName((__bridge CTFontRef)font, kCTFontPostScriptNameKey));
				pointSize = CTFontGetSize((__bridge CTFontRef)font);
			}
			
			[mutableAttributedString removeAttribute:(NSString *)kCTFontAttributeName range:range];
			CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, CGFloat_floor(pointSize * scale), NULL);
			[mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
			CFRelease(fontRef);
		}
	}];
	
	return mutableAttributedString;
}
@interface EQAttributedLabel ()
@property (readwrite, nonatomic) CTFramesetterRef           framesetter;
@property (readwrite, nonatomic) CTFramesetterRef           highlightFramesetter;
@property (readwrite, nonatomic, copy) NSAttributedString *renderedAttributedText;
@property (readwrite, nonatomic, retain) NSDataDetector             *dataDetector;
@property (readwrite, nonatomic, retain) NSArray                    *links;
@property (readwrite, nonatomic, retain) UITapGestureRecognizer     *tapGestureRecognizer;

- (void)commonInit;
- (void)setNeedsFramesetter;
- (NSTextCheckingResult *)linkAtCharacterIndex:(CFIndex)idx;
- (NSTextCheckingResult *)linkAtPoint:(CGPoint)p;
- (CFIndex)characterIndexAtPoint:(CGPoint)p;
- (void)drawFramesetter:(CTFramesetterRef)framesetter textRange:(CFRange)textRange inRect:(CGRect)rect context:(CGContextRef)c;
- (void)drawStrike:(CTFrameRef)frame inRect:(CGRect)rect context:(CGContextRef)c;
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer;
@end

@implementation EQAttributedLabel
@synthesize attributedText = _attributedText;
@synthesize framesetter = _framesetter;
@synthesize highlightFramesetter = _highlightFramesetter;
@synthesize delegate = _delegate;
@synthesize dataDetectorTypes = _dataDetectorTypes;
@synthesize dataDetector = _dataDetector;
@synthesize links = _links;
@synthesize shadowRadius = _shadowRadius;
@synthesize leading = _leading;
@synthesize lineHeightMultiple = _lineHeightMultiple;
@synthesize firstLineIndent = _firstLineIndent;
@synthesize textInsets = _textInsets;
@synthesize verticalAlignment = _verticalAlignment;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)awakeFromNib
{
    [self commonInit];
}

- (void)commonInit {
	self.linkBackgroundEdgeInset = UIEdgeInsetsMake(0.0f, -1.0f, 0.0f, -1.0f);
	self.lineHeightMultiple = 1.0f;

    self.links = [NSArray array];
    self.numberOfLines = 0;
    self.textInsets = UIEdgeInsetsZero;
    self.userInteractionEnabled = YES;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.tapGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)dealloc {
    if (_framesetter) CFRelease(_framesetter);
    if (_highlightFramesetter) CFRelease(_highlightFramesetter);
}

#pragma mark -

- (void)setAttributedText:(NSAttributedString *)text {
    if ([text isEqualToAttributedString:self.attributedText]) {
        return;
    }
    
    [self willChangeValueForKey:@"attributedText"];
    _attributedText = [text copy];
    [self didChangeValueForKey:@"attributedText"];
    
    [self setNeedsFramesetter];
}

- (CGFloat)leading {
	return self.lineSpacing;
}

- (void)setLeading:(CGFloat)leading {
	self.lineSpacing = leading;
}

- (NSAttributedString *)renderedAttributedText {
	if (!_renderedAttributedText) {
		self.renderedAttributedText = NSAttributedStringBySettingColorFromContext(self.attributedText, self.textColor);
	}
	
	return _renderedAttributedText;
}

- (void)setFramesetter:(CTFramesetterRef)framesetter {
	if (framesetter) {
		CFRetain(framesetter);
	}
	
	if (_framesetter) {
		CFRelease(_framesetter);
	}
	
	_framesetter = framesetter;
}

- (CTFramesetterRef)highlightFramesetter {
	return _highlightFramesetter;
}

- (void)setHighlightFramesetter:(CTFramesetterRef)highlightFramesetter {
	if (highlightFramesetter) {
		CFRetain(highlightFramesetter);
	}
	
	if (_highlightFramesetter) {
		CFRelease(_highlightFramesetter);
	}
	
	_highlightFramesetter = highlightFramesetter;
}

- (void)setNeedsFramesetter {
	// Reset the rendered attributed text so it has a chance to regenerate
	self.renderedAttributedText = nil;
	
	_needsFramesetter = YES;
}

- (CTFramesetterRef)framesetter {
    if (_needsFramesetter) {
        @synchronized(self) {
			CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.renderedAttributedText);
			[self setFramesetter:framesetter];
			[self setHighlightFramesetter:nil];
			_needsFramesetter = NO;
			
			if (framesetter) {
				CFRelease(framesetter);
			}
		}
    }
		
    return _framesetter;
}

- (void)drawBackground:(CTFrameRef)frame
				inRect:(CGRect)rect
			   context:(CGContextRef)c
{
	NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
	CGPoint origins[[lines count]];
	CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
	
	CFIndex lineIndex = 0;
	for (id line in lines) {
		CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
		CGFloat width = (CGFloat)CTLineGetTypographicBounds((__bridge CTLineRef)line, &ascent, &descent, &leading) ;
		
		for (id glyphRun in (__bridge NSArray *)CTLineGetGlyphRuns((__bridge CTLineRef)line)) {
			NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes((__bridge CTRunRef) glyphRun);
			CGColorRef strokeColor = CGColorRefFromColor([attributes objectForKey:kBackgroundStrokeColorAttributeName]);
			CGColorRef fillColor = CGColorRefFromColor([attributes objectForKey:kBackgroundFillColorAttributeName]);
			UIEdgeInsets fillPadding = [[attributes objectForKey:kBackgroundFillPaddingAttributeName] UIEdgeInsetsValue];
			CGFloat cornerRadius = [[attributes objectForKey:kBackgroundCornerRadiusAttributeName] floatValue];
			CGFloat lineWidth = [[attributes objectForKey:kBackgroundLineWidthAttributeName] floatValue];
			
			if (strokeColor || fillColor) {
				CGRect runBounds = CGRectZero;
				CGFloat runAscent = 0.0f;
				CGFloat runDescent = 0.0f;
				
				runBounds.size.width = (CGFloat)CTRunGetTypographicBounds((__bridge CTRunRef)glyphRun, CFRangeMake(0, 0), &runAscent, &runDescent, NULL) + fillPadding.left + fillPadding.right;
				runBounds.size.height = runAscent + runDescent + fillPadding.top + fillPadding.bottom;
				
				CGFloat xOffset = 0.0f;
				CFRange glyphRange = CTRunGetStringRange((__bridge CTRunRef)glyphRun);
				switch (CTRunGetStatus((__bridge CTRunRef)glyphRun)) {
					case kCTRunStatusRightToLeft:
						xOffset = CTLineGetOffsetForStringIndex((__bridge CTLineRef)line, glyphRange.location + glyphRange.length, NULL);
						break;
					default:
						xOffset = CTLineGetOffsetForStringIndex((__bridge CTLineRef)line, glyphRange.location, NULL);
						break;
				}
				
				runBounds.origin.x = origins[lineIndex].x + rect.origin.x + xOffset - fillPadding.left - rect.origin.x;
				runBounds.origin.y = origins[lineIndex].y + rect.origin.y - fillPadding.bottom - rect.origin.y;
				runBounds.origin.y -= runDescent;
				
				// Don't draw higlightedLinkBackground too far to the right
				if (CGRectGetWidth(runBounds) > width) {
					runBounds.size.width = width;
				}
				
				CGPathRef path = [[UIBezierPath bezierPathWithRoundedRect:CGRectInset(UIEdgeInsetsInsetRect(runBounds, self.linkBackgroundEdgeInset), lineWidth, lineWidth) cornerRadius:cornerRadius] CGPath];
				
				CGContextSetLineJoin(c, kCGLineJoinRound);
				
				if (fillColor) {
					CGContextSetFillColorWithColor(c, fillColor);
					CGContextAddPath(c, path);
					CGContextFillPath(c);
				}
				
				if (strokeColor) {
					CGContextSetStrokeColorWithColor(c, strokeColor);
					CGContextAddPath(c, path);
					CGContextStrokePath(c);
				}
			}
		}
		
		lineIndex++;
	}
}
- (void)drawFramesetter:(CTFramesetterRef)framesetter
	   attributedString:(NSAttributedString *)attributedString
			  textRange:(CFRange)textRange
				 inRect:(CGRect)rect
				context:(CGContextRef)c {
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, rect);
	CTFrameRef frame = CTFramesetterCreateFrame(framesetter, textRange, path, NULL);
	
	[self drawBackground:frame inRect:rect context:c];
	
	CFArrayRef lines = CTFrameGetLines(frame);
	NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
	BOOL truncateLastLine = (self.lineBreakMode == NSLineBreakByTruncatingHead || self.lineBreakMode == NSLineBreakByTruncatingMiddle || self.lineBreakMode == NSLineBreakByTruncatingTail);
	
	CGPoint lineOrigins[numberOfLines];
	CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
	
	for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
		CGPoint lineOrigin = lineOrigins[lineIndex];
		CGContextSetTextPosition(c, lineOrigin.x, lineOrigin.y);
		CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
		
		CGFloat descent = 0.0f;
		CTLineGetTypographicBounds((CTLineRef)line, NULL, &descent, NULL);
		
		// Adjust pen offset for flush depending on text alignment
		CGFloat flushFactor = EQTFlushFactorForTextAlignment(self.textAlignment);
		
		if (lineIndex == numberOfLines - 1 && truncateLastLine) {
			// Check if the range of text in the last line reaches the end of the full attributed string
			CFRange lastLineRange = CTLineGetStringRange(line);
			
			if (!(lastLineRange.length == 0 && lastLineRange.location == 0) && lastLineRange.location + lastLineRange.length < textRange.location + textRange.length) {
				// Get correct truncationType and attribute position
				CTLineTruncationType truncationType;
				CFIndex truncationAttributePosition = lastLineRange.location;
				NSLineBreakMode lineBreakMode = self.lineBreakMode;
				
				// Multiple lines, only use UILineBreakModeTailTruncation
				if (numberOfLines != 1) {
					lineBreakMode = NSLineBreakByTruncatingTail;
				}
				
				switch (lineBreakMode) {
					case NSLineBreakByTruncatingHead:
						truncationType = kCTLineTruncationStart;
						break;
					case NSLineBreakByTruncatingMiddle:
						truncationType = kCTLineTruncationMiddle;
						truncationAttributePosition += (lastLineRange.length / 2);
						break;
					case NSLineBreakByTruncatingTail:
					default:
						truncationType = kCTLineTruncationEnd;
						truncationAttributePosition += (lastLineRange.length - 1);
						break;
				}
				
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
				NSAttributedString *attributedTruncationString = self.attributedTruncationToken;
				if (!attributedTruncationString) {
					NSString *truncationTokenString = self.truncationTokenString;
					if (!truncationTokenString) {
						truncationTokenString = @"\u2026"; // Unicode Character 'HORIZONTAL ELLIPSIS' (U+2026)
					}
					
					NSDictionary *truncationTokenStringAttributes = self.truncationTokenStringAttributes;
					if (!truncationTokenStringAttributes) {
						truncationTokenStringAttributes = [attributedString attributesAtIndex:(NSUInteger)truncationAttributePosition effectiveRange:NULL];
					}
					
					attributedTruncationString = [[NSAttributedString alloc] initWithString:truncationTokenString attributes:truncationTokenStringAttributes];
				}
				CTLineRef truncationToken = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attributedTruncationString);
#pragma clang diagnostic pop
				
				// Append truncationToken to the string
				// because if string isn't too long, CT won't add the truncationToken on its own.
				// There is no chance of a double truncationToken because CT only adds the
				// token if it removes characters (and the one we add will go first)
				NSMutableAttributedString *truncationString = [[NSMutableAttributedString alloc] initWithAttributedString:
															   [attributedString attributedSubstringFromRange:
																NSMakeRange((NSUInteger)lastLineRange.location,
																			(NSUInteger)lastLineRange.length)]];
				if (lastLineRange.length > 0) {
					// Remove any newline at the end (we don't want newline space between the text and the truncation token). There can only be one, because the second would be on the next line.
					unichar lastCharacter = [[truncationString string] characterAtIndex:(NSUInteger)(lastLineRange.length - 1)];
					if ([[NSCharacterSet newlineCharacterSet] characterIsMember:lastCharacter]) {
						[truncationString deleteCharactersInRange:NSMakeRange((NSUInteger)(lastLineRange.length - 1), 1)];
					}
				}
				[truncationString appendAttributedString:attributedTruncationString];
				CTLineRef truncationLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncationString);
				
				// Truncate the line in case it is too long.
				CTLineRef truncatedLine = CTLineCreateTruncatedLine(truncationLine, rect.size.width, truncationType, truncationToken);
				if (!truncatedLine) {
					// If the line is not as wide as the truncationToken, truncatedLine is NULL
					truncatedLine = CFRetain(truncationToken);
				}
				
				CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(truncatedLine, flushFactor, rect.size.width);
				CGContextSetTextPosition(c, penOffset, lineOrigin.y - descent - self.font.descender);
				
				CTLineDraw(truncatedLine, c);
				
				NSRange linkRange;
				if ([attributedTruncationString attribute:NSLinkAttributeName atIndex:0 effectiveRange:&linkRange]) {
					NSRange tokenRange = [truncationString.string rangeOfString:attributedTruncationString.string];
					NSRange tokenLinkRange = NSMakeRange((NSUInteger)(lastLineRange.location+lastLineRange.length)-tokenRange.length, (NSUInteger)tokenRange.length);
					
//					[self addLinkToURL:[attributedTruncationString attribute:NSLinkAttributeName atIndex:0 effectiveRange:&linkRange] withRange:tokenLinkRange];
				}
				
				CFRelease(truncatedLine);
				CFRelease(truncationLine);
				CFRelease(truncationToken);
			} else {
				CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, rect.size.width);
				CGContextSetTextPosition(c, penOffset, lineOrigin.y - descent - self.font.descender);
				CTLineDraw(line, c);
			}
		} else {
			CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, rect.size.width);
			CGContextSetTextPosition(c, penOffset, lineOrigin.y - descent - self.font.descender);
			CTLineDraw(line, c);
		}
	}
	
	[self drawStrike:frame inRect:rect context:c];
	
	CFRelease(frame);
	CGPathRelease(path);
}

- (void)drawStrike:(CTFrameRef)frame inRect:(CGRect)rect context:(CGContextRef)c {
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    CGPoint origins[[lines count]];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
	
    NSUInteger lineIndex = 0;
    for (id line in lines) {
        CGRect lineBounds = CTLineGetImageBounds((CTLineRef)line, c);
        lineBounds.origin.x = origins[lineIndex].x;
        lineBounds.origin.y = origins[lineIndex].y;
		
        for (id glyphRun in (NSArray *)CTLineGetGlyphRuns((CTLineRef)line)) {
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes((CTRunRef) glyphRun);
            BOOL strikeOut = [[attributes objectForKey:kEQStrikeOutAttributeName] boolValue];
            NSInteger superscriptStyle = [[attributes objectForKey:(id)kCTSuperscriptAttributeName] integerValue];
			
            if (strikeOut) {
                CGRect runBounds = CGRectZero;
                CGFloat ascent = 0.0f;
                CGFloat descent = 0.0f;
				
                runBounds.size.width = CTRunGetTypographicBounds((CTRunRef)glyphRun, CFRangeMake(0, 0), &ascent, &descent, NULL);
                runBounds.size.height = ascent + descent;
				
                CGFloat xOffset = CTLineGetOffsetForStringIndex((CTLineRef)line, CTRunGetStringRange((CTRunRef)glyphRun).location, NULL);
                runBounds.origin.x = origins[lineIndex].x + rect.origin.x + xOffset;
                runBounds.origin.y = origins[lineIndex].y + rect.origin.y;
                runBounds.origin.y -= descent;
                
                // Don't draw strikeout too far to the right
                if (CGRectGetWidth(runBounds) > CGRectGetWidth(lineBounds)) {
                    runBounds.size.width = CGRectGetWidth(lineBounds);
                }
                
                switch (superscriptStyle) {
                    case 1:
                        runBounds.origin.y -= ascent * 0.47f;
                        break;
                    case -1:
                        runBounds.origin.y += ascent * 0.25f;
                        break;
                    default:
                        break;
                }
                
                // Use text color, or default to black
                id color = [attributes objectForKey:(id)kCTForegroundColorAttributeName];
                
                if (color) {
                    CGContextSetStrokeColorWithColor(c, (CGColorRef)color);
                } else {
                    CGContextSetGrayStrokeColor(c, 0.0f, 1.0);
                }
                
                CTFontRef font = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
                CGContextSetLineWidth(c, CTFontGetUnderlineThickness(font));
                CGFloat y = roundf(runBounds.origin.y + runBounds.size.height / 2.0f);
                CGContextMoveToPoint(c, runBounds.origin.x, y);
                CGContextAddLineToPoint(c, runBounds.origin.x + runBounds.size.width, y);
				CFRelease(font);
                CGContextStrokePath(c);
            }
        }
        
        lineIndex++;
    }
}

- (void)addLinkWithTextCheckingResult:(NSTextCheckingResult *)result attributes:(NSDictionary *)attributes {
    self.links = [self.links arrayByAddingObject:result];
    
    if (attributes && attributes.count > 0) {
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [mutableAttributedString addAttributes:attributes range:result.range];
        self.attributedText = mutableAttributedString;
    }
}

- (void)addLinkWithSpecialHandleDictionary:(NSDictionary *)dic withRange:(NSRange)range withAttributes:(NSDictionary*)attributes
{
    NSTextCheckingResult *trs =[NSTextCheckingResult transitInformationCheckingResultWithRange:range components:dic];
    [self addLinkWithTextCheckingResult:trs attributes:attributes];
}

- (void)addLinkWithSpecialHandleText:(NSString *)text withRange:(NSRange)range withAttributes:(NSDictionary*)attributes
{
    NSTextCheckingResult *trs =[NSTextCheckingResult correctionCheckingResultWithRange:range replacementString:text];
    [self addLinkWithTextCheckingResult:trs attributes:attributes];
}
#pragma mark - AttributedLabel
- (void)setText:(id)text {
	if ([self isCalc]) {
		[self changeFrameWithText:text];
	}
    if ([text isKindOfClass:[NSString class]]) {
        [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:nil];
    } else {
        self.attributedText = text;
    }
    [super setText:[self.attributedText string]];
}

- (void)setText:(id)text afterInheritingLabelAttributesAndConfiguringWithBlock:(NSMutableAttributedString *(^)(NSMutableAttributedString *mutableAttributedString))block {
    NSMutableAttributedString *mutableAttributedString = nil;
    if ([text isKindOfClass:[NSString class]]) {
        mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:NSAttributedStringAttributesFromLabel(self)];
    } else {
        mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:text];
        [mutableAttributedString addAttributes:NSAttributedStringAttributesFromLabel(self) range:NSMakeRange(0, [mutableAttributedString length])];
    }
    if (block) {
        mutableAttributedString = block(mutableAttributedString);
    }
    [self setText:mutableAttributedString];
}

- (void)changeFrameWithText:(id)text
{
//	NSString *textHeight;
//	if ([text isKindOfClass:[NSAttributedString class]]) {
//		textHeight = ((NSAttributedString *)text).string;
//	}
//	else {
//		textHeight = (NSString *)text;
//	}
//	CGSize realSize = [iFMCurveDrawTool getHeightWithUseFont:self.font andWithContent:textHeight andWithPadding:self.leading andWithUseRect:CGSizeMake(self.frame.size.width, FLOAT_MAX)];
//	if (self.limitHeight > 0 && realSize.height >= self.limitHeight && _openLimit) {
//		realSize.height = self.limitHeight;
//	}
//	if (realSize.height > self.frame.size.height) {
//		CGRect newframe = self.frame;
//		newframe.size.height = realSize.height;
//		self.frame = newframe;
//	}
}

#pragma mark - UILabel

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}


- (CGRect)textRectForBounds:(CGRect)bounds
	 limitedToNumberOfLines:(NSInteger)numberOfLines
{
	bounds = UIEdgeInsetsInsetRect(bounds, self.textInsets);
	if (!self.attributedText) {
		return [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
	}
	
	CGRect textRect = bounds;
	
	// Calculate height with a minimum of double the font pointSize, to ensure that CTFramesetterSuggestFrameSizeWithConstraints doesn't return CGSizeZero, as it would if textRect height is insufficient.
	textRect.size.height = MAX(self.font.lineHeight * MAX(2, numberOfLines), bounds.size.height);
	
	// Adjust the text to be in the center vertically, if the text size is smaller than bounds
	CGSize textSize = CTFramesetterSuggestFrameSizeWithConstraints([self framesetter], CFRangeMake(0, (CFIndex)[self.attributedText length]), NULL, textRect.size, NULL);
	textSize = CGSizeMake(CGFloat_ceil(textSize.width), CGFloat_ceil(textSize.height)); // Fix for iOS 4, CTFramesetterSuggestFrameSizeWithConstraints sometimes returns fractional sizes
	
	if (textSize.height < bounds.size.height) {
		CGFloat yOffset = 0.0f;
		switch (self.verticalAlignment) {
			case EQAttributedLabelVerticalAlignmentCenter:
				yOffset = CGFloat_floor((bounds.size.height - textSize.height) / 2.0f);
				break;
			case EQAttributedLabelVerticalAlignmentBottom:
				yOffset = bounds.size.height - textSize.height;
				break;
			case EQAttributedLabelVerticalAlignmentTop:
			default:
				break;
		}
		
		textRect.origin.y += yOffset;
	}
	
	return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
	CGRect insetRect = UIEdgeInsetsInsetRect(rect, self.textInsets);
	if (!self.attributedText) {
		[super drawTextInRect:insetRect];
		return;
	}
	
	NSAttributedString *originalAttributedText = nil;
	
	// Adjust the font size to fit width, if necessarry
	if (self.adjustsFontSizeToFitWidth && self.numberOfLines > 0) {
		// Framesetter could still be working with a resized version of the text;
		// need to reset so we start from the original font size.
		// See #393.
		[self setNeedsFramesetter];
		[self setNeedsDisplay];
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
		if ([self respondsToSelector:@selector(invalidateIntrinsicContentSize)]) {
			[self invalidateIntrinsicContentSize];
		}
#endif
		
		// Use infinite width to find the max width, which will be compared to availableWidth if needed.
		CGSize maxSize = (self.numberOfLines > 1) ? CGSizeMake(100000, 100000) : CGSizeZero;
		
		CGFloat textWidth = [self sizeThatFits:maxSize].width;
		CGFloat availableWidth = self.frame.size.width * self.numberOfLines;
		if (self.numberOfLines > 1 && self.lineBreakMode == NSLineBreakByWordWrapping) {
			textWidth *= (M_PI / M_E);
		}
		
		if (textWidth > availableWidth && textWidth > 0.0f) {
			originalAttributedText = [self.attributedText copy];
			
			CGFloat scaleFactor = availableWidth / textWidth;
			if ([self respondsToSelector:@selector(minimumScaleFactor)] && self.minimumScaleFactor > scaleFactor) {
				scaleFactor = self.minimumScaleFactor;
			}
			
			self.attributedText = NSAttributedStringByScalingFontSize(self.attributedText, scaleFactor);
		}
	}
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSaveGState(c);
	{
		CGContextSetTextMatrix(c, CGAffineTransformIdentity);
		
		// Inverts the CTM to match iOS coordinates (otherwise text draws upside-down; Mac OS's system is different)
		CGContextTranslateCTM(c, 0.0f, insetRect.size.height);
		CGContextScaleCTM(c, 1.0f, -1.0f);
		
		CFRange textRange = CFRangeMake(0, (CFIndex)[self.attributedText length]);
		
		// First, get the text rect (which takes vertical centering into account)
		CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
		
		// CoreText draws its text aligned to the bottom, so we move the CTM here to take our vertical offsets into account
		CGContextTranslateCTM(c, insetRect.origin.x, insetRect.size.height - textRect.origin.y - textRect.size.height);
		
		// Second, trace the shadow before the actual text, if we have one
//		if (self.shadowColor && !self.highlighted) {
//			CGContextSetShadowWithColor(c, self.shadowOffset, self.shadowRadius, [self.shadowColor CGColor]);
//		} else if (self.highlightedShadowColor) {
//			CGContextSetShadowWithColor(c, self.highlightedShadowOffset, self.highlightedShadowRadius, [self.highlightedShadowColor CGColor]);
//		}
		
		// Finally, draw the text or highlighted text itself (on top of the shadow, if there is one)
		if (self.highlightedTextColor && self.highlighted) {
			NSMutableAttributedString *highlightAttributedString = [self.renderedAttributedText mutableCopy];
			[highlightAttributedString addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName value:(id)[self.highlightedTextColor CGColor] range:NSMakeRange(0, highlightAttributedString.length)];
			
			if (![self highlightFramesetter]) {
				CTFramesetterRef highlightFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)highlightAttributedString);
				[self setHighlightFramesetter:highlightFramesetter];
				CFRelease(highlightFramesetter);
			}
			
			[self drawFramesetter:[self highlightFramesetter] attributedString:highlightAttributedString textRange:textRange inRect:textRect context:c];
		} else {
			[self drawFramesetter:[self framesetter] attributedString:self.renderedAttributedText textRange:textRange inRect:textRect context:c];
		}
		
		// If we adjusted the font size, set it back to its original size
		if (originalAttributedText) {
			// Use ivar directly to avoid clearing out framesetter and renderedAttributedText
			_attributedText = originalAttributedText;
		}
	}
	CGContextRestoreGState(c);
}



#pragma mark - UIView

- (CGSize)sizeThatFits:(CGSize)size {
    if (!self.attributedText) {
        return [super sizeThatFits:size];
    }
	
    CFRange rangeToSize = CFRangeMake(0, [self.attributedText length]);
    CGSize constraints = CGSizeMake(size.width, CGFLOAT_MAX);
	
    if (self.numberOfLines == 1) {
        // If there is one line, the size that fits is the full width of the line
        constraints = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    } else if (self.numberOfLines > 0) {
        // If the line count of the label more than 1, limit the range to size to the number of lines that have been set
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0.0f, 0.0f, constraints.width, CGFLOAT_MAX));
        CTFrameRef frame = CTFramesetterCreateFrame(self.framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
		
        if (CFArrayGetCount(lines) > 0) {
            NSInteger lastVisibleLineIndex = MIN(self.numberOfLines, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = (CTLineRef)CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
			
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            rangeToSize = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        
        CFRelease(frame);
        CFRelease(path);
    }
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(self.framesetter, rangeToSize, NULL, constraints, NULL);
    
    return CGSizeMake(ceilf(suggestedSize.width), ceilf(suggestedSize.height));
}

- (NSTextCheckingResult *)linkAtCharacterIndex:(CFIndex)idx {
    for (NSTextCheckingResult *result in self.links) {
        NSRange range = result.range;
        if ((CFIndex)range.location <= idx && idx <= (CFIndex)(range.location + range.length - 1)) {
            return result;
        }
    }
    return nil;
}

- (NSTextCheckingResult *)linkAtPoint:(CGPoint)p {
    CFIndex idx = [self characterIndexAtPoint:p];
    return [self linkAtCharacterIndex:idx];
}

- (CFIndex)characterIndexAtPoint:(CGPoint)p {
	if (!CGRectContainsPoint(self.bounds, p)) {
		return NSNotFound;
	}
	
	CGRect textRect = self.bounds;
	if (!CGRectContainsPoint(textRect, p)) {
		return NSNotFound;
	}
	
	// Offset tap coordinates by textRect origin to make them relative to the origin of frame
	p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y);
	// Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
	p = CGPointMake(p.x, textRect.size.height - p.y);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, textRect);
	CTFrameRef frame = CTFramesetterCreateFrame([self framesetter], CFRangeMake(0, (CFIndex)[self.attributedText length]), path, NULL);
	if (frame == NULL) {
		CGPathRelease(path);
		return NSNotFound;
	}
	
	CFArrayRef lines = CTFrameGetLines(frame);
	NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
	if (numberOfLines == 0) {
		CFRelease(frame);
		CGPathRelease(path);
		return NSNotFound;
	}
	
	CFIndex idx = NSNotFound;
	
	CGPoint lineOrigins[numberOfLines];
	CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
	
	for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
		CGPoint lineOrigin = lineOrigins[lineIndex];
		CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, lineIndex);
		
		// Get bounding information of line
		CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
		CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
		CGFloat yMin = (CGFloat)floor(lineOrigin.y - descent);
		CGFloat yMax = (CGFloat)ceil(lineOrigin.y + ascent);
		
		// Apply penOffset using flushFactor for horizontal alignment to set lineOrigin since this is the horizontal offset from drawFramesetter
		CGFloat flushFactor = EQTFlushFactorForTextAlignment(self.textAlignment);
		CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, textRect.size.width);
		lineOrigin.x = penOffset;
		
		// Check if we've already passed the line
		if (p.y > yMax) {
			break;
		}
		// Check if the point is within this line vertically
		if (p.y >= yMin) {
			// Check if the point is within this line horizontally
			if (p.x >= lineOrigin.x && p.x <= lineOrigin.x + width) {
				// Convert CT coordinates to line-relative coordinates
				CGPoint relativePoint = CGPointMake(p.x - lineOrigin.x, p.y - lineOrigin.y);
				idx = CTLineGetStringIndexForPosition(line, relativePoint);
				break;
			}
		}
	}
	
	CFRelease(frame);
	CGPathRelease(path);
	
	return idx;
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer state] != UIGestureRecognizerStateEnded) {
        return;
    }
    NSTextCheckingResult *result = [self linkAtPoint:[gestureRecognizer locationInView:self]];
    if (!result || !self.delegate) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLabelSpecialTextKey:)]) {
        [self.delegate attributedLabel:self didSelectLabelSpecialTextKey:result.components];
    }
}


#pragma mark - 手势事件穿透判断
- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	if ([self isCalc]) {
		NSTextCheckingResult *result = [self linkAtPoint:[touch locationInView:self]];
		if (!result) {
			return NO;
		}
	}
	return YES;
}

-(Boolean)isCalc
{
    return NO;
}
@end



@implementation EQAttributedLabelEx

-(Boolean)isCalc
{
    return YES;
}

@end
