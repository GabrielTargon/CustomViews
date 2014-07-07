//
//  CircleSlider.m
//  CustomViews
//
//  Created by Gustavo Lima on 11/24/13.
//  Copyright (c) 2013 Gustavo Lima. All rights reserved.
//

#import "CircleSlider.h"
#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180)
#define RADIANS_TO_DEGREES(degrees) ((180 * degrees)/ M_PI)
#define TB_SAFEAREA_PADDING 60
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )

@interface CircleSlider(){
    // TODO: Caso queira definir variaveis privadas aqui
    int radius;
}
@end

@implementation CircleSlider


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
       // TODO: Criar inicialização
        self.value = 0.0;
        self.thumbCenterPoint = CGPointZero;
        self.angle = 0;
        self.angleWrite = 0;
        radius = self.bounds.size.width/2;
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // TODO: Desenhar a View customizada como o exemplo fornecido no arquivo Exemplo_Resultado.png
    [super drawRect:rect];
    
    //Desenha circulo maior
    UIBezierPath *circleBig = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [self.circleColor setFill];
    [circleBig fill];
    
    
    //Desenha circulo menor
    UIBezierPath *circleSmall = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleBig.bounds.origin.x + (circleBig.bounds.size.width / 2), circleBig.bounds.origin.y + (circleBig.bounds.size.height / 2))
                                                               radius:self.circleRadius
                                                           startAngle:0
                                                             endAngle:360
                                                            clockwise:YES];
    [[UIColor whiteColor] setFill];
    [circleSmall fill];
    
    //Desenha a 'linha' do slider
    float lineRadius = (((self.bounds.size.width/2) - self.circleRadius) /2) + self.circleRadius;
    UIBezierPath *handleLine = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.origin.x + (self.bounds.size.width/2), self.bounds.origin.y + (self.bounds.size.height/2))
                                                              radius:lineRadius
                                                          startAngle:0
                                                            endAngle:self.angle
                                                           clockwise:NO];
    
    [handleLine setLineWidth: self.lineWidth]; //Define tamanho linha

    
    // Desenho do texto central
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *angleTextFont = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:radius * 0.4];
    
    
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", self.angleWrite]
                                                               attributes:@{NSFontAttributeName : angleTextFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : self.textColor}];
    self.angleWrite = 360 - RADIANS_TO_DEGREES(self.angle);
    CGRect textBounds;
    textBounds.origin = CGPointMake(radius - (text.size.width / 2), radius - (text.size.height / 2));
    textBounds.size = [text size];
    
    [text drawInRect:textBounds];
    
    
    
    
    //Desenha gradient
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width,self.bounds.size.height));
    CGContextRef imageCtx = UIGraphicsGetCurrentContext();
    
    if (self.angle < 0) {
        self.angle = -self.angle;
    }
    else {
        self.angle = 2*M_PI - self.angle;
    }

    CGContextAddArc(imageCtx, self.bounds.size.width/2 , self.bounds.size.height/2, radius * 0.775, 0, self.angle, 0);
    [[UIColor redColor]set];
    
    //Shadow
    CGContextSetShadowWithColor(imageCtx, CGSizeMake(0, 0), self.angle/2, [UIColor blackColor].CGColor);
    
    CGContextSetLineWidth(imageCtx, self.bounds.size.width/8);
    CGContextDrawPath(imageCtx, kCGPathStroke);
    

    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    /** Clip Context to the mask **/
    CGContextSaveGState(ctx);
    
    CGContextClipToMask(ctx, self.bounds, mask);
    CGImageRelease(mask);
    
    /** THE GRADIENT **/
    
    //list of components
    
    const float* start = CGColorGetComponents(self.startColor.CGColor);
    const float* end = CGColorGetComponents(self.endColor.CGColor);
    CGFloat components[8] = {
        start[0], start[1], start[2], start[3],     // Start color - Blue
        end[0], end[1], end[2], end[3] };   // End color - Violet
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    //Gradient direction
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    //Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(ctx);
    
    //Desenho da circulo do slider
    CGFloat handleRadius = radius * 0.135;
    CGPoint handleCenter = CGPointMake(self.bounds.size.width/2 + radius * 0.775 * cos(self.angle), self.bounds.size.height/2 + radius * 0.775 * sin(-self.angle));
    
    UIBezierPath *handle = [UIBezierPath bezierPathWithArcCenter:handleCenter
                                                          radius:handleRadius
                                                      startAngle:0
                                                        endAngle:DEGREES_TO_RADIANS(360)
                                                       clockwise:YES];
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, [UIColor blackColor].CGColor);
    [self.handleColor setFill];
    [handle fill];

    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *currentTouch = [touches anyObject];
    CGPoint tapLocation = [currentTouch locationInView:self];
    
            float sliderCenter = atan2(tapLocation.y - self.bounds.size.height/2, tapLocation.x - self.bounds.size.width/2);
            float sliderStartPoint = atan2(self.bounds.size.height/2 - self.bounds.size.height/2, self.bounds.size.width - self.bounds.size.width/2);
    
            if(sliderStartPoint-sliderCenter < 0){
                sliderStartPoint+=2*M_PI;
            }
            
            self.angle = sliderStartPoint - sliderCenter;
            
            if (self.angle < 0) {
                self.angle = -self.angle;
            }
            else {
                self.angle = 2*M_PI - self.angle;
            }
    [self setNeedsDisplay];
}


@end
