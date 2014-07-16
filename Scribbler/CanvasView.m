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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 40.0f);
    
    for (int i=0; i<self.strokes.count; i++) {
        [self drawStroke:(NSArray*)self.strokes[i] withContext:context];
    }
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

- (void)drawStroke:(NSArray*)points withContext:(CGContextRef)context
{
    if (points.count>1) {
        CGPoint p = [((NSValue*)points[0]) CGPointValue];
        CGContextMoveToPoint(context, p.x, p.y); //start at this point
      
        for (int i=1; i<points.count; i++) {
            CGPoint p = [((NSValue*)points[0]) CGPointValue];
            
            CGContextAddLineToPoint(context, p.x, p.y); //draw to this point
        }
    }
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentStroke = [[NSMutableArray alloc]init];
//    self.currentStroke addObject:[NSValue valueWithCG]
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
