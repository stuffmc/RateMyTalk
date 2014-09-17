//
//  JBRatingView.h
//  ThessFest
//
//  Created by Juxhin Bakalli on 10/15/12.
//  Copyright (c) 2012 Juxhin Bakalli. All rights reserved.
//  SocialSensor
//

#import <UIKit/UIKit.h>

@interface JBRatingView : UIView

typedef void(^RatingObserverBlock)(CGFloat rating);

@property (assign, readonly) CGFloat rating;
@property (nonatomic, strong) UIColor *mainBackgroundColor;

- (id)initWithRating:(CGFloat)rating;
- (void)updateRatingTo:(CGFloat)rating;
- (void)ratingChangObserverBlock:(RatingObserverBlock)block;

@end
