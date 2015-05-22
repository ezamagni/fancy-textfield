//
//  YWATextField.h
//  TextFieldTest
//
//  Created by Enrico Zamagni on 21/05/15.
//  Copyright (c) 2015 Enrico Zamagni. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FancyTextField : UITextField

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, assign) IBInspectable CGFloat placeholderScale;

@end
