//
//  UIPlaceHolderTextView.h
//  Patter
//
//  Created by Maksim Ivanov on 08/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef UIPlaceHolderTextView_h
#define UIPlaceHolderTextView_h

IB_DESIGNABLE
@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

#endif /* UIPlaceHolderTextView_h */
