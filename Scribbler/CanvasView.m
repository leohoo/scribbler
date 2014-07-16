//
//  CanvasView.m
//  Scribbler
//
//  Created by Liu Wei on 7/16/14.
//  Copyright (c) 2014 Liu Wei. All rights reserved.
//

#import "CanvasView.h"

@interface CanvasView()

@property (strong) NSMutableArray* strokes;
@property (strong) NSMutableArray* currentStroke;
@end

@implementation CanvasView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.strokes = [[NSMutableArray alloc]init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.strokes = [[NSMutableArray alloc]init];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
 
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 20.0f);
    for (int i=0; i<self.strokes.count; i++) {
        [self drawStroke:(NSArray*)self.strokes[i] withContext:context];
    }
    CGContextStrokePath(context);
}

- (void)drawStroke:(NSArray*)points withContext:(CGContextRef)context
{
    if (points.count>1) {
        CGPoint p = [((NSValue*)points[0]) CGPointValue];
        CGContextMoveToPoint(context, p.x, p.y); //start at this point
        
        for (int i=1; i<points.count; i++) {
            CGPoint p = [((NSValue*)points[i]) CGPointValue];
            
            CGContextAddLineToPoint(context, p.x, p.y); //draw to this point
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentStroke = [[NSMutableArray alloc]init];
    
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    [self.currentStroke addObject:[NSValue valueWithCGPoint:p]];
    [self.strokes addObject:self.currentStroke];
     NSLog(@"began: %f, %f", p.x, p.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];

    [self.currentStroke addObject:[NSValue valueWithCGPoint:p]];
    
    [self setNeedsDisplay];
    
    NSLog(@"moved: %f, %f", p.x, p.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
  
    CGPoint p = [[touches anyObject] locationInView:self];

     NSLog(@"end: %f, %f", p.x, p.y);
}

@end
