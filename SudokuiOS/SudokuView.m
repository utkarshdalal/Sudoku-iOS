//
//  SudokuView.m
//  SudokuiOS
//
//  Created by Utkarsh Dalal on 11/20/13.
//  Copyright (c) 2013 Utkarsh Dalal. All rights reserved.
//

#import "SudokuView.h"

@interface SudokuView (hidden)

-(CGRect)drawHashInBounds:(CGRect)bounds usingColor:(UIColor*)color;

@end

@implementation SudokuView (hidden)

-(CGRect)drawHashInBounds:(CGRect)bounds usingColor:(UIColor*)color
{
    
    CGFloat top = bounds.origin.y;
    CGFloat bottom = top + bounds.size.height;
    CGFloat left = bounds.origin.x;
    CGFloat right = left + bounds.size.width;
    CGFloat thirdHeight = bounds.size.height/3;
    CGFloat thirdWidth = bounds.size.width/3;
    
    CGFloat lineWidth = ( thirdWidth > thirdHeight ) ? thirdWidth / 30.0 : thirdHeight / 30.0;
    
    UIBezierPath *framePath = [UIBezierPath bezierPath];
    
    [framePath moveToPoint:CGPointMake(left+thirdWidth,top)];
    [framePath addLineToPoint:CGPointMake(left+thirdWidth,bottom)];
    [framePath moveToPoint:CGPointMake(right-thirdWidth,top)];
    [framePath addLineToPoint:CGPointMake(right-thirdWidth,bottom)];
    [framePath moveToPoint:CGPointMake(left,top+thirdHeight)];
    [framePath addLineToPoint:CGPointMake(right,top+thirdHeight)];
    [framePath moveToPoint:CGPointMake(left,bottom-thirdHeight)];
    [framePath addLineToPoint:CGPointMake(right,bottom-thirdHeight)];
    
    [color setStroke];
    
    [framePath setLineWidth:lineWidth];
    
    [framePath stroke];
    
    return CGRectMake(bounds.origin.x, bounds.origin.y, thirdWidth, thirdHeight);
}

-(void)paintSelectionRectangle
{
    CGFloat thirdWidth = self.bounds.size.width / 3.0;
    CGFloat thirdHeight = self.bounds.size.height / 3.0;
    CGFloat ninthWidth = thirdWidth / 3.0;
    CGFloat ninthHeight = thirdHeight / 3.0;
    
    CGRect selectionRect = CGRectMake(_selectionCellX * thirdWidth + _selectionX * ninthWidth,
                                      _selectionCellY * thirdHeight + _selectionY * ninthHeight,
                                      ninthWidth, ninthHeight);
    
    UIColor* selectionColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    [selectionColor setFill];
    UIBezierPath* selectionPath = [UIBezierPath bezierPathWithRoundedRect:selectionRect cornerRadius:ninthHeight/4.0];
    [selectionPath fill];
    UITextField* textView = [[UITextField alloc] initWithFrame:selectionRect];
    textView.backgroundColor = [UIColor clearColor];
    textView.keyboardType = UIKeyboardTypeNumberPad;
    textView.hidden = YES;
    textView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textView];
    [textView becomeFirstResponder];
    [textView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void) textFieldDidChange: (UITextField *) textView
{
    if (![self._viewController isOriginalValueAtCellX:_selectionCellX andCellY:_selectionCellY xIndex:_selectionX yIndex:_selectionY]) {
        [self._viewController setCurrentValue:[textView.text integerValue] atCellX:_selectionCellX andCellY:_selectionCellY xIndex:_selectionX yIndex:_selectionY];
        [self setNeedsDisplay];
    }
    [textView resignFirstResponder];
}

@end

@implementation SudokuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGRect oneSquareBounds = [self drawHashInBounds:self.bounds usingColor:[UIColor blackColor]];
    
    for (UInt32 y = 0; y < 3; y++)
    {
        for (UInt32 x = 0; x < 3; x++)
        {
            CGRect smallBounds = CGRectOffset(oneSquareBounds, x * oneSquareBounds.size.width, y * oneSquareBounds.size.height);
            
            smallBounds = CGRectInset(smallBounds, 0.0, 0.0);
            
            [self drawHashInBounds: smallBounds usingColor: [UIColor grayColor]];
            [self drawValueAtCellX:x andCellY:y inBounds:smallBounds];
        }
    }
    if (_haveSelection)
    {
        [self paintSelectionRectangle];
    }
    if ([self._viewController isPuzzleSolved])
    {
        NSInteger fourth = self.bounds.size.height / 4;
        
        UIColor* winColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.33];
        
        UIFont *font = [UIFont fontWithName:@"Zapfino" size:60];
        
        NSDictionary* attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         font, NSFontAttributeName, winColor, NSForegroundColorAttributeName,
                                         [NSNumber numberWithDouble:16.0], NSStrokeWidthAttributeName, nil];
        
        CGPoint solvedDrawPosition = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + fourth);
        
        [@"SOLVED!" drawAtPoint:solvedDrawPosition withAttributes:attrsDictionary];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: self];
    CGFloat thirds = self.bounds.size.width / 3;
    CGFloat ninths = thirds / 3;
    
    _selectionCellX = (UInt32)( location.x / thirds );
    _selectionCellY = (UInt32)( location.y / thirds );
    _selectionX = (UInt32)( ( location.x - ( _selectionCellX * thirds ) ) / ninths );
    _selectionY = (UInt32)( ( location.y - ( _selectionCellY * thirds ) ) / ninths );
    
    if ([self._viewController isOriginalValueAtCellX:_selectionCellX andCellY:_selectionCellY xIndex:_selectionX yIndex:_selectionY])
    {
        _haveSelection = NO;
    }
    
    else
    {
        _haveSelection = YES;
    }
    
    
    [self setNeedsDisplay];
}

-(void)drawValueAtCellX:(int)cellX andCellY:(int)cellY inBounds:(CGRect)bounds
{
    if (self._viewController._sudokuModel)
    {
        CGFloat thirdWidth = bounds.size.width / 3.0;
        CGFloat thirdHeight = bounds.size.height / 3.0;
        
        for (int y=0; y<3; y++)
        {
            for (int x=0; x<3; x++)
            {
                int value = [self._viewController getCurrentValueAtCellX:cellX andCellY:cellY
                                                                    xIndex:x yIndex:y];
                
                if ( value != 0 )
                {
                    CGPoint valueDrawPosition = CGPointMake (bounds.origin.x +
                                                            x * thirdWidth + thirdWidth / 3,
                                                            bounds.origin.y +
                                                            y * thirdHeight + thirdHeight / 6);
                    
                    NSString* valueString = [NSString stringWithFormat:@"%c",(char)value+'0'];
                    
                    UIFont *font = [UIFont fontWithName:@"American Typewriter" size:thirdHeight/2.0];
                    
                    UIColor* color;
                    
                    if ([self._viewController isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y])
                    {
                        color = [UIColor blackColor];
                    }
                    else
                    {
                        color = [UIColor blueColor];
                    }
                    
                    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     font, NSFontAttributeName,
                                                     color, NSForegroundColorAttributeName,
                                                     nil];
                    
                    [valueString drawAtPoint:valueDrawPosition withAttributes:attrsDictionary];
                }
            }
        }
    }
}

@end
