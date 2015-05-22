//
//  YWATextField.m
//  TextFieldTest
//
//  Created by Enrico Zamagni on 21/05/15.
//  Copyright (c) 2015 Enrico Zamagni. All rights reserved.
//

#import "FancyTextField.h"

@interface FancyTextField ()

@property (nonatomic, strong) UILabel *phLabel;
@property (nonatomic, assign) BOOL falling;

@end

@implementation FancyTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self phInit];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self phInit];
    }
    return self;
}

- (void)phInit {
//    self.phLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    
//    // init label attributes with default values..
//    _phLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    _phLabel.numberOfLines = 0;
//    _phLabel.font = [self.font fontWithSize:self.font.pointSize * 0.33];
//    _phLabel.backgroundColor = [UIColor clearColor];
//    _phLabel.text = self.placeholder;
//    _phLabel.textColor = [UIColor blackColor];
//    _phLabel.alpha = 1;
//    _phLabel.hidden = YES;
    
//    self.falling = NO;
    //[self addSubview:self.phLabel];
    //[self bringSubviewToFront:self.phLabel];
    self.placeholderScale = 0.65;
    [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

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

- (UILabel*) setupLabelFrom:(UILabel*)source {
    UILabel *label = [[UILabel alloc] initWithFrame:source.frame];
    
    label.lineBreakMode = source.lineBreakMode;
    label.font = [source.font copy];
    label.text = [source.text copy];
    label.textColor = [source.textColor copy];
    label.alpha = source.alpha;
    [self setAnchorPoint:CGPointZero forView:label];
    
    return label;
}

-(void) textDidChange {
    if (!_phLabel)
        return;
    
    //CGFloat startPosition_y = (self.frame.size.height - self.phLabel.frame.size.height) / 2;
    
    if (self.text.length > 0 && !_phLabel.superview) {
        // start rising
//        _phLabel.frame = CGRectMake(4.0, startPosition_y, phSize.width, phSize.height);
//        self.phLabel.hidden = NO;
        [super addSubview:_phLabel];
        [super bringSubviewToFront:_phLabel];
        
        [UIView animateWithDuration:0.42 animations:^{
            //_phLabel.alpha = 1;
            //_phLabel.frame = CGRectMake(4.0, 4.0, phSize.width, phSize.height);

            CGFloat dy = 4.0 - _phLabel.frame.origin.y;
            CGAffineTransform t = CGAffineTransformScale(CGAffineTransformIdentity, _placeholderScale, _placeholderScale);
            t = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0, dy);
            _phLabel.transform = t;
        }];
    }
    else if (self.text.length == 0 && !self.falling) {
        // start falling
//        self.falling = YES;
//        CGRect phFrame = _phLabel.frame;
//        
//        [UIView animateWithDuration:0.42 animations:^{
//            _phLabel.alpha = 0;
//            _phLabel.frame = CGRectMake(phFrame.origin.x, startPosition_y, phFrame.size.width, phFrame.size.height);
//        } completion:^(BOOL finished) {
//            self.falling = NO;
//            _phLabel.hidden = YES;
//        }];
    }
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);

    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);

    CGPoint position = view.layer.position;

    position.x -= oldPoint.x;
    position.x += newPoint.x;

    position.y -= oldPoint.y;
    position.y += newPoint.y;

    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
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
