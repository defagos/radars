//
//  CustomView.m
//  live-rendering-bug
//
//  Created by Samuel Défago on 04.06.14.
//  Copyright (c) 2014 Samuel Défago. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(CGRect)rect
{
    // Draw something nice :)
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(82.5, 18.5, 78, 72)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    [[UIColor blackColor] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    UIBezierPath *oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(100.5, 40.5, 7, 7)];
    [[UIColor whiteColor] setFill];
    [oval2Path fill];
    [[UIColor blackColor] setStroke];
    oval2Path.lineWidth = 1;
    [oval2Path stroke];
    
    UIBezierPath *oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(129.5, 40.5, 7, 7)];
    [[UIColor whiteColor] setFill];
    [oval3Path fill];
    [[UIColor blackColor] setStroke];
    oval3Path.lineWidth = 1;
    [oval3Path stroke];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(103.5, 64.5)];
    [bezierPath addCurveToPoint: CGPointMake(136.5, 66.5) controlPoint1: CGPointMake(116.5, 78.5) controlPoint2: CGPointMake(136.5, 66.5)];
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

@end
