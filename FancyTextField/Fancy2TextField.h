//
//  Fancy2TextField.h
//  FancyTextField
//
//  Created by Enrico Zamagni on 23/05/15.
//  Copyright (c) 2015 Enrico Zamagni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fancy2TextField : UITextField

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, assign) IBInspectable CGFloat placeholderScale;
@property (nonatomic, assign) IBInspectable BOOL uppercase;

@end
