//
//  Fancy1TextField.h
//  FancyTextField
//
//  Created by Enrico Zamagni on 22/05/15.
//  Copyright (c) 2015 Enrico Zamagni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fancy1TextField : UITextField

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, assign) IBInspectable CGFloat placeholderScale;
@property (nonatomic, assign) IBInspectable BOOL uppercase;

@end
