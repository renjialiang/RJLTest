//
//  EQAttributedLabel.h
//  testLayout
//
//  Created by renjialiang on 15/12/23.
//  Copyright © 2015年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
//#import "UIColor+Hex.h"
#define colorKey        @"c"
#define rangeKey        @"range"
#define actionTypeKey   @"at"
#define actionKey       @"a"
#define fontKey         @"font"
#define valueKey        @"v"
#define valueTKey       @"k"
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
typedef enum {
    EQAttributedLabelVerticalAlignmentCenter   = 0,
    EQAttributedLabelVerticalAlignmentTop      = 1,
    EQAttributedLabelVerticalAlignmentBottom   = 2,
} EQAttributedLabelVerticalAlignment;

extern NSString * const kEQStrikeOutAttributeName;
@protocol EQAttributedLabelDelegate;

// Override UILabel @property to accept both NSString and NSAttributedString
@protocol EQAttributedLabel <NSObject>
@property (nonatomic, copy) id text;
@end
@interface EQAttributedLabel : UILabel  <EQAttributedLabel, UIGestureRecognizerDelegate>
{
    @private
    NSAttributedString                  *_attributedText;
    CTFramesetterRef                    _framesetter;
    BOOL                                _needsFramesetter;
    UIDataDetectorTypes                 _dataDetectorTypes;
    NSDataDetector                      *_dataDetector;
    NSArray                             *_links;
    CGFloat                             _shadowRadius;
    CGFloat                             _leading;
    CGFloat                             _lineHeightMultiple;
    CGFloat                             _firstLineIndent;
    UIEdgeInsets                        _textInsets;
    EQAttributedLabelVerticalAlignment  _verticalAlignment;
    UITapGestureRecognizer              *_tapGestureRecognizer;
}

- (CGFloat)caculateSelfFrameHeight:(NSDictionary *)data;
@property (nonatomic, retain) NSString                      *dataId;
@property (nonatomic, weak) id <EQAttributedLabelDelegate> delegate;
@property (nonatomic) NSInteger							limitHeight;
@property (nonatomic) BOOL	openLimit;
@property (nonatomic, strong) NSString *truncationTokenString DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) UIEdgeInsets linkBackgroundEdgeInset;

/**
 @deprecated Use `attributedTruncationToken` instead.
 */
@property (nonatomic, strong) NSDictionary *truncationTokenStringAttributes DEPRECATED_ATTRIBUTE;

/**
 The attributed string to apply to the truncation token at the end of a truncated line. Overrides `truncationTokenStringAttributes` and `truncationTokenString`. If unspecified, attributes will fallback to `truncationTokenStringAttributes` and `truncationTokenString`.
 */
@property (nonatomic, strong) IBInspectable NSAttributedString *attributedTruncationToken;
@property (nonatomic) BOOL	isSetInitializeHeightValue;
@property (nonatomic) CGFloat initailizeHeight;

/**
 A bitmask of `UIDataDetectorTypes` which are used to automatically detect links in the label text. This is `UIDataDetectorTypeNone` by default.
 
 @warning You must specify `dataDetectorTypes` before setting the `text`, with either `setText:` or `setText:afterInheritingLabelAttributesAndConfiguringWithBlock:`.
 */
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes;

/**
 An array of `NSTextCheckingResult` objects for links detected or manually added to the label text.
 */
@property (readonly,nonatomic, retain) NSArray *links;

/**
 A dictionary containing the `NSAttributedString` attributes to be applied to links detected or manually added to the label text. The default link style is blue and underlined.
 
 @warning You must specify `linkAttributes` before setting autodecting or manually-adding links for these attributes to be applied.
 */
@property (nonatomic, retain) NSDictionary *linkAttributes;

///---------------------------------------
/// @name Acccessing Text Style Attributes
///---------------------------------------

/**
 The shadow blur radius for the label. A value of 0 indicates no blur, while larger values produce correspondingly larger blurring. This value must not be negative. The default value is 0.
 */
@property (nonatomic) CGFloat shadowRadius;

///--------------------------------------------
/// @name Acccessing Paragraph Style Attributes
///--------------------------------------------

/**
 The distance, in points, from the leading margin of a frame to the beginning of the paragraph's first line. This value is always nonnegative, and is 0.0 by default.
 */
@property (nonatomic) CGFloat firstLineIndent;

/**
 The space in points added between lines within the paragraph. This value is always nonnegative and is 0.0 by default.
 */
@property (nonatomic) CGFloat leading;

/**
 The space in points added between lines within the paragraph. This value is always nonnegative and is 0.0 by default.
 */
@property (nonatomic) IBInspectable CGFloat lineSpacing;

/**
 The amount to kern the next character. Default is standard kerning. If this attribute is set to 0.0, no kerning is done at all.
 */
@property (nonatomic) IBInspectable CGFloat kern;

/**
 The minimum line height within the paragraph. If the value is 0.0, the minimum line height is set to the line height of the `font`. 0.0 by default.
 */
@property (nonatomic) IBInspectable CGFloat minimumLineHeight;

/**
 The maximum line height within the paragraph. If the value is 0.0, the maximum line height is set to the line height of the `font`. 0.0 by default.
 */
@property (nonatomic) IBInspectable CGFloat maximumLineHeight;

/**
 The line height multiple. This value is 0.0 by default.
 */
@property (nonatomic) CGFloat lineHeightMultiple;

/**
 The distance, in points, from the margin to the text container. This value is `UIEdgeInsetsZero` by default.
 
 @discussion The `UIEdgeInset` members correspond to paragraph style properties rather than a particular geometry, and can change depending on the writing direction.
 
 ## `UIEdgeInset` Member Correspondence With `CTParagraphStyleSpecifier` Values:
 
 - `top`: `kCTParagraphStyleSpecifierParagraphSpacingBefore`
 - `left`: `kCTParagraphStyleSpecifierHeadIndent`
 - `bottom`: `kCTParagraphStyleSpecifierParagraphSpacing`
 - `right`: `kCTParagraphStyleSpecifierTailIndent`
 
 */
@property (nonatomic) UIEdgeInsets textInsets;

/**
 The vertical text alignment for the label, for when the frame size is greater than the text rect size. The vertical alignment is `TTTAttributedLabelVerticalAlignmentCenter` by default.
 */
@property (nonatomic) EQAttributedLabelVerticalAlignment verticalAlignment;
- (void)addLinkWithSpecialHandleText:(NSString *)text withRange:(NSRange)range withAttributes:(NSDictionary*)attributes;
- (void)addLinkWithSpecialHandleDictionary:(NSDictionary *)dic withRange:(NSRange)range withAttributes:(NSDictionary*)attributes;
- (void)commonInit;//初始化
- (void)setText:(id)text;

- (void)setText:(id)text afterInheritingLabelAttributesAndConfiguringWithBlock:(NSMutableAttributedString *(^)(NSMutableAttributedString *mutableAttributedString))block;

-(Boolean)isCalc;
@end
@protocol EQAttributedLabelDelegate <NSObject>
@optional
- (void)attributedLabel:(EQAttributedLabel *)label didSelectLabelSpecialTextKey:(NSDictionary *)dic;
@end

@interface EQAttributedLabelEx : EQAttributedLabel

-(Boolean)isCalc;

@end



