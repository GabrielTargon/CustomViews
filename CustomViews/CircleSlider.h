//
//  CircleSlider.h
//  CustomViews
//
//  Created by Gustavo Lima on 11/24/13.
//  Copyright (c) 2013 Gustavo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TB_SLIDER_SIZE 320                          //The width and the heigth of the slider
#define TB_BACKGROUND_WIDTH 60                      //The width of the dark background
#define TB_LINE_WIDTH 40                            //The width of the active area (the gradient) and the width of the handle
#define TB_FONTSIZE 65                              //The size of the textfield font
#define TB_FONTFAMILY @"Futura-CondensedExtraBold"  //The font family of the textfield font


@interface CircleSlider : UIView

// Angulo de posição do slider
@property (nonatomic,assign) CGFloat angle;

// Primeira cor de preenchimento do slider
@property (nonatomic,strong) UIColor *startColor;

// Segunda cor de preenchimento do slider
@property (nonatomic,strong) UIColor *endColor;

// Cor da bolinha do marcador de posição
@property (nonatomic,strong) UIColor *handleColor;

// Cor de fundo
@property (nonatomic,strong) UIColor *circleColor;

// Cor do texto central
@property (nonatomic,strong) UIColor *textColor;

// TODO: Caso necessário defina mais propriedades aqui abaixo

// Raio do circulo menor
@property (nonatomic,assign) int circleRadius;

// Raio da linha
//@property (nonatomic,assign) int lineRadius;

// Raio do slider
//@property (nonatomic,assign) int sliderRadius;

// Grossura da linha
@property (nonatomic,assign) int lineWidth;

@property (nonatomic) float value;
@property (nonatomic) CGPoint thumbCenterPoint;
@property (nonatomic) float angleWrite;



//float translateValueFromSourceIntervalToDestinationInterval(float sourceValue, float sourceIntervalMinimum, float sourceIntervalMaximum, float destinationIntervalMinimum, float destinationIntervalMaximum);


@end
