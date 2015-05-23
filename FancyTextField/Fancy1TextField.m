//
//  Fancy1TextField.m
//  FancyTextField
//
//  Created by Enrico Zamagni on 22/05/15.
//  Copyright (c) 2015 Enrico Zamagni. All rights reserved.
//

#import "Fancy1TextField.h"

@interface Fancy1TextField ()

@property (nonatomic, strong) UILabel *phLabel;
@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) BOOL animating;

@end

static const CGFloat PH_TOP_INSET = 4;

@implementation Fancy1TextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initState];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initState];
    }
    return self;
}

- (void) initState {
    _placeholderColor = [UIColor blackColor];
    _placeholderScale = 0.6;
    _startRect = CGRectZero;
    _animating = NO;

    [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

# pragma mark -

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];

    if (!self.phLabel) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *labelView = (UILabel*)subview;
            if ([labelView.text isEqualToString:self.placeholder] && !labelView.userInteractionEnabled) {
                _phLabel = [self setupLabelFrom:labelView];
            }
        }
    }
}

- (UILabel*)setupLabelFrom:(UILabel*)label {
    UIFont *phFont = [label.font fontWithSize:label.font.pointSize * _placeholderScale];
    NSString *phText = _uppercase ? [label.text uppercaseString] : label.text;
    CGSize phSize = [phText sizeWithAttributes:@{NSFontAttributeName : phFont}];

    _startRect = CGRectMake(label.frame.origin.x, (self.frame.size.height - phSize.height) / 2.0,
                            phSize.width, phSize.height);

    UILabel *phLabel = [[UILabel alloc] initWithFrame:_startRect];
    phLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    phLabel.backgroundColor = [UIColor clearColor];
    phLabel.textColor = _placeholderColor;
    phLabel.userInteractionEnabled = NO;
    phLabel.numberOfLines = 0;
    phLabel.text = phText;
    phLabel.font = phFont;
    phLabel.alpha = 0;

    return phLabel;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect superRect = [super textRectForBounds:bounds];
    return CGRectMake(superRect.origin.x, superRect.origin.y + _startRect.size.height / 2 + PH_TOP_INSET,
                      superRect.size.width, superRect.size.height - _startRect.size.height / 2);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect superRect = [super editingRectForBounds:bounds];
    return CGRectMake(superRect.origin.x, superRect.origin.y + _startRect.size.height / 2 + PH_TOP_INSET,
                      superRect.size.width, superRect.size.height - _startRect.size.height / 2);
}

- (void) textDidChange {
    if (!_phLabel || _animating)
        return;

    if (!_phLabel.superview && self.text.length > 0) {
        // start rising
        [self addSubview:_phLabel];
        [self bringSubviewToFront:_phLabel];
        CGRect phFrame = _phLabel.frame;
        _animating = YES;

        [UIView animateWithDuration:0.42 animations:^{
            _phLabel.alpha = 1.0;
            _phLabel.frame = CGRectMake(phFrame.origin.x, PH_TOP_INSET,
                                        phFrame.size.width, phFrame.size.height);
        } completion:^(BOOL finished) {
            _animating = NO;
        }];
    }
    else if (self.text.length == 0) {
        // start falling
        _animating = YES;

        [UIView animateWithDuration:0.33 animations:^{
            _phLabel.alpha = 0.0;
            _phLabel.frame = _startRect;
        } completion:^(BOOL finished) {
            _animating = NO;
            [_phLabel removeFromSuperview];
            _phLabel = nil;
        }];
    }
}

#pragma mark - Getters & Setters

-(void)setPlaceholderScale:(CGFloat)placeholderScale {
    if (placeholderScale < 0.0)
        _placeholderScale = 0.0;
    else if (placeholderScale > 1.0)
        _placeholderScale = 1.0;
    else
        _placeholderScale = placeholderScale;
}

@end
