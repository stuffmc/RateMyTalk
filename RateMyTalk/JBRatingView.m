//
//  JBRatingView.m
//  ThessFest
//
//  Created by Juxhin Bakalli on 10/15/12.
//  Copyright (c) 2012 Juxhin Bakalli. All rights reserved.
//

#import "JBRatingView.h"

#define kMaxWidthValue          172.0

@interface JBRatingView ()

@property (assign, readwrite) CGFloat rating;
@property (assign) CGFloat ratingWidth;
@property (nonatomic, strong) RatingObserverBlock observerBlock;

@end

@implementation JBRatingView

- (void)initialize
{
    [self updateRatingTo:0.0];
    
    if ( !self.mainBackgroundColor) {
        self.mainBackgroundColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:tapGesture];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect
{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

- (id)initWithRating:(CGFloat)rating
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)ratingChangObserverBlock:(RatingObserverBlock)block
{
    _observerBlock = block;
}

- (void)updateRatingTo:(CGFloat)rating
{
    dispatch_async( dispatch_get_main_queue(), ^{
        if (_observerBlock) {
            _observerBlock(rating);
        }
    });
    
    self.rating = rating;
    _ratingWidth = kMaxWidthValue * self.rating / 5;
    [self setNeedsDisplay];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self updateRatingTo:[self rateForX:[gesture locationInView:self].x]];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self updateRatingTo:[self rateForX:[gesture locationInView:self].x]];
        }
            break;
        case UIGestureRecognizerStateRecognized:
        {
            [self updateRatingTo:[self rateForX:[gesture locationInView:self].x]];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)rateForX:(CGFloat)xValue
{
    CGFloat x = xValue - 3;
    if (x > 175) {
        x -= 2;
    }
    
    if (x < 43.0) {
        return 1.0;
    } else if (x >= 43.0 && x < 77.4) {
        return 2.0;
    } else if (x >= 77.4 && x < 111.8) {
        return 3.0;
    } else if (x >= 111.8 && x < 146.2) {
        return 4.0;
    } else if (x >= 146.2) {
        return 5.0;
    }
    return 0.0;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* emptyStarColor = [UIColor colorWithRed:0.678 green:0.665 blue:0.642 alpha:1.000];
    UIColor* lightFillStarGradientColor = [UIColor colorWithRed:0.791 green:0.053 blue:0.144 alpha:1.000];
    UIColor* fullStarColor = [UIColor colorWithRed:0.791 green:0.053 blue:0.144 alpha:1.000];
    
    CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 =0.0;
    [lightFillStarGradientColor getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    CGFloat red2 = 0.0, green2 = 0.0, blue2 = 0.0, alpha2 =0.0;
    [fullStarColor getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    //// Gradient Declarations
    NSArray* gradient2Colors = [NSArray arrayWithObjects:
                                (id)lightFillStarGradientColor.CGColor,
                                (id)[UIColor colorWithRed: (red1 + red2)/2 green: (green1 + green2)/2 blue: (blue1 + blue2)/2 alpha: (alpha1 + alpha2)/2].CGColor,
//                                (id)[UIColor colorWithRed: 0.61 green: 0.782 blue: 0.883 alpha: 1].CGColor,
                                (id)fullStarColor.CGColor, nil];
    CGFloat gradient2Locations[] = {0, 0, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat shadowBlurRadius = 6;
    
    //// Frames
    CGRect frame = rect;
    
    
    //// star1 Drawing
    UIBezierPath* star1Path = [UIBezierPath bezierPath];
    [star1Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 16.68, CGRectGetMinY(frame) + 1.39)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 14.28, CGRectGetMinY(frame) + 12.55)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 3.48, CGRectGetMinY(frame) + 16.19)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 13.34, CGRectGetMinY(frame) + 21.93)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 13.45, CGRectGetMinY(frame) + 33.35)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 21.93, CGRectGetMinY(frame) + 25.72)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 32.81, CGRectGetMinY(frame) + 29.14)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 28.2, CGRectGetMinY(frame) + 18.7)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 34.8, CGRectGetMinY(frame) + 9.39)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 23.47, CGRectGetMinY(frame) + 10.56)];
    [star1Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 16.68, CGRectGetMinY(frame) + 1.39)];
    [star1Path closePath];
    [emptyStarColor setFill];
    [star1Path fill];
    
    ////// star1 Inner Shadow
    CGRect star1BorderRect = CGRectInset([star1Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    star1BorderRect = CGRectOffset(star1BorderRect, -shadowOffset.width, -shadowOffset.height);
    star1BorderRect = CGRectInset(CGRectUnion(star1BorderRect, [star1Path bounds]), -1, -1);
    
    UIBezierPath* star1NegativePath = [UIBezierPath bezierPathWithRect: star1BorderRect];
    [star1NegativePath appendPath: star1Path];
    star1NegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(star1BorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [star1Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(star1BorderRect.size.width), 0);
        [star1NegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [star1NegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// star2 Drawing
    UIBezierPath* star2Path = [UIBezierPath bezierPath];
    [star2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 51.68, CGRectGetMinY(frame) + 1.39)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 49.28, CGRectGetMinY(frame) + 12.55)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 38.48, CGRectGetMinY(frame) + 16.19)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 48.34, CGRectGetMinY(frame) + 21.93)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 48.45, CGRectGetMinY(frame) + 33.35)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 56.93, CGRectGetMinY(frame) + 25.72)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 67.81, CGRectGetMinY(frame) + 29.14)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 63.2, CGRectGetMinY(frame) + 18.7)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 69.8, CGRectGetMinY(frame) + 9.39)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 58.47, CGRectGetMinY(frame) + 10.56)];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 51.68, CGRectGetMinY(frame) + 1.39)];
    [star2Path closePath];
    [emptyStarColor setFill];
    [star2Path fill];
    
    ////// star2 Inner Shadow
    CGRect star2BorderRect = CGRectInset([star2Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    star2BorderRect = CGRectOffset(star2BorderRect, -shadowOffset.width, -shadowOffset.height);
    star2BorderRect = CGRectInset(CGRectUnion(star2BorderRect, [star2Path bounds]), -1, -1);
    
    UIBezierPath* star2NegativePath = [UIBezierPath bezierPathWithRect: star2BorderRect];
    [star2NegativePath appendPath: star2Path];
    star2NegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(star2BorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [star2Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(star2BorderRect.size.width), 0);
        [star2NegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [star2NegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// star3 Drawing
    UIBezierPath* star3Path = [UIBezierPath bezierPath];
    [star3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 86.68, CGRectGetMinY(frame) + 1.39)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 84.28, CGRectGetMinY(frame) + 12.55)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 73.48, CGRectGetMinY(frame) + 16.19)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 83.34, CGRectGetMinY(frame) + 21.93)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 83.45, CGRectGetMinY(frame) + 33.35)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 91.93, CGRectGetMinY(frame) + 25.72)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 102.81, CGRectGetMinY(frame) + 29.14)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 98.2, CGRectGetMinY(frame) + 18.7)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 104.8, CGRectGetMinY(frame) + 9.39)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 93.47, CGRectGetMinY(frame) + 10.56)];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 86.68, CGRectGetMinY(frame) + 1.39)];
    [star3Path closePath];
    [emptyStarColor setFill];
    [star3Path fill];
    
    ////// star3 Inner Shadow
    CGRect star3BorderRect = CGRectInset([star3Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    star3BorderRect = CGRectOffset(star3BorderRect, -shadowOffset.width, -shadowOffset.height);
    star3BorderRect = CGRectInset(CGRectUnion(star3BorderRect, [star3Path bounds]), -1, -1);
    
    UIBezierPath* star3NegativePath = [UIBezierPath bezierPathWithRect: star3BorderRect];
    [star3NegativePath appendPath: star3Path];
    star3NegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(star3BorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [star3Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(star3BorderRect.size.width), 0);
        [star3NegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [star3NegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// star4 Drawing
    UIBezierPath* star4Path = [UIBezierPath bezierPath];
    [star4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 121.68, CGRectGetMinY(frame) + 1.39)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 119.28, CGRectGetMinY(frame) + 12.55)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 108.48, CGRectGetMinY(frame) + 16.19)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 118.34, CGRectGetMinY(frame) + 21.93)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 118.45, CGRectGetMinY(frame) + 33.35)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 126.93, CGRectGetMinY(frame) + 25.72)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 137.81, CGRectGetMinY(frame) + 29.14)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 133.2, CGRectGetMinY(frame) + 18.7)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.8, CGRectGetMinY(frame) + 9.39)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 128.47, CGRectGetMinY(frame) + 10.56)];
    [star4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 121.68, CGRectGetMinY(frame) + 1.39)];
    [star4Path closePath];
    [emptyStarColor setFill];
    [star4Path fill];
    
    ////// star4 Inner Shadow
    CGRect star4BorderRect = CGRectInset([star4Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    star4BorderRect = CGRectOffset(star4BorderRect, -shadowOffset.width, -shadowOffset.height);
    star4BorderRect = CGRectInset(CGRectUnion(star4BorderRect, [star4Path bounds]), -1, -1);
    
    UIBezierPath* star4NegativePath = [UIBezierPath bezierPathWithRect: star4BorderRect];
    [star4NegativePath appendPath: star4Path];
    star4NegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(star4BorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [star4Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(star4BorderRect.size.width), 0);
        [star4NegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [star4NegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// star5 Drawing
    UIBezierPath* star5Path = [UIBezierPath bezierPath];
    [star5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 156.68, CGRectGetMinY(frame) + 1.39)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 154.28, CGRectGetMinY(frame) + 12.55)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 143.48, CGRectGetMinY(frame) + 16.19)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 153.34, CGRectGetMinY(frame) + 21.93)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 153.45, CGRectGetMinY(frame) + 33.35)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 161.93, CGRectGetMinY(frame) + 25.72)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 172.81, CGRectGetMinY(frame) + 29.14)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 168.2, CGRectGetMinY(frame) + 18.7)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 174.8, CGRectGetMinY(frame) + 9.39)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 163.47, CGRectGetMinY(frame) + 10.56)];
    [star5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 156.68, CGRectGetMinY(frame) + 1.39)];
    [star5Path closePath];
    [emptyStarColor setFill];
    [star5Path fill];
    
    ////// star5 Inner Shadow
    CGRect star5BorderRect = CGRectInset([star5Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    star5BorderRect = CGRectOffset(star5BorderRect, -shadowOffset.width, -shadowOffset.height);
    star5BorderRect = CGRectInset(CGRectUnion(star5BorderRect, [star5Path bounds]), -1, -1);
    
    UIBezierPath* star5NegativePath = [UIBezierPath bezierPathWithRect: star5BorderRect];
    [star5NegativePath appendPath: star5Path];
    star5NegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(star5BorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [star5Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(star5BorderRect.size.width), 0);
        [star5NegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [star5NegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// fillingStarBackground Drawing
    CGRect fillingStarBackgroundRect = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 1, _ratingWidth, 32);
    UIBezierPath* fillingStarBackgroundPath = [UIBezierPath bezierPathWithRect: fillingStarBackgroundRect];
    CGContextSaveGState(context);
    [fillingStarBackgroundPath addClip];
    CGContextDrawLinearGradient(context, gradient2,
                                CGPointMake(CGRectGetMidX(fillingStarBackgroundRect), CGRectGetMinY(fillingStarBackgroundRect)),
                                CGPointMake(CGRectGetMidX(fillingStarBackgroundRect), CGRectGetMaxY(fillingStarBackgroundRect)),
                                0);
    CGContextRestoreGState(context);
    
    
    //// starHoles Drawing
    UIBezierPath* starHolesPath = [UIBezierPath bezierPath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 156.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 154.28, CGRectGetMinY(frame) + 12.55)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 143.48, CGRectGetMinY(frame) + 16.19)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 153.34, CGRectGetMinY(frame) + 21.93)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 153.45, CGRectGetMinY(frame) + 33.35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 161.93, CGRectGetMinY(frame) + 25.72)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 172.81, CGRectGetMinY(frame) + 29.14)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 168.2, CGRectGetMinY(frame) + 18.7)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 174.8, CGRectGetMinY(frame) + 9.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 163.47, CGRectGetMinY(frame) + 10.56)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 156.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath closePath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 121.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 119.28, CGRectGetMinY(frame) + 12.55)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 108.48, CGRectGetMinY(frame) + 16.19)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 118.34, CGRectGetMinY(frame) + 21.93)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 118.45, CGRectGetMinY(frame) + 33.35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 126.93, CGRectGetMinY(frame) + 25.72)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 137.81, CGRectGetMinY(frame) + 29.14)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 133.2, CGRectGetMinY(frame) + 18.7)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.8, CGRectGetMinY(frame) + 9.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 128.47, CGRectGetMinY(frame) + 10.56)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 121.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath closePath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 86.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 84.28, CGRectGetMinY(frame) + 12.55)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 73.48, CGRectGetMinY(frame) + 16.19)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 83.34, CGRectGetMinY(frame) + 21.93)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 83.45, CGRectGetMinY(frame) + 33.35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 91.93, CGRectGetMinY(frame) + 25.72)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 102.81, CGRectGetMinY(frame) + 29.14)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 98.2, CGRectGetMinY(frame) + 18.7)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 104.8, CGRectGetMinY(frame) + 9.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 93.47, CGRectGetMinY(frame) + 10.56)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 86.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath closePath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 51.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 49.28, CGRectGetMinY(frame) + 12.55)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 38.48, CGRectGetMinY(frame) + 16.19)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 48.34, CGRectGetMinY(frame) + 21.93)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 48.45, CGRectGetMinY(frame) + 33.35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 56.93, CGRectGetMinY(frame) + 25.72)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 67.81, CGRectGetMinY(frame) + 29.14)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 63.2, CGRectGetMinY(frame) + 18.7)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 69.8, CGRectGetMinY(frame) + 9.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 58.47, CGRectGetMinY(frame) + 10.56)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 51.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath closePath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 16.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 14.28, CGRectGetMinY(frame) + 12.55)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 3.48, CGRectGetMinY(frame) + 16.19)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 13.34, CGRectGetMinY(frame) + 21.93)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 13.45, CGRectGetMinY(frame) + 33.35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 21.93, CGRectGetMinY(frame) + 25.72)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 32.81, CGRectGetMinY(frame) + 29.14)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 28.2, CGRectGetMinY(frame) + 18.7)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 34.8, CGRectGetMinY(frame) + 9.39)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 23.47, CGRectGetMinY(frame) + 10.56)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 16.68, CGRectGetMinY(frame) + 1.39)];
    [starHolesPath closePath];
    [starHolesPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 178, CGRectGetMinY(frame) + 35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 35)];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame))];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 178, CGRectGetMinY(frame))];
    [starHolesPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 178, CGRectGetMinY(frame) + 35)];
    [starHolesPath closePath];
    [self.mainBackgroundColor setFill];
    [starHolesPath fill];
    
    
    //// Cleanup
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
}


@end
