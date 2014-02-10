//
//  SudokuViewController.m
//  SudokuiOS
//
//  Created by Utkarsh Dalal on 11/20/13.
//  Copyright (c) 2013 Utkarsh Dalal. All rights reserved.
//

#import "SudokuViewController.h"

@interface SudokuViewController ()

@end

@implementation SudokuViewController

@synthesize _sudokuModel, _sudokuView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _sudokuModel = [SudokuModel sharedModel];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-( BOOL )isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                         xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    if ( [ self getOriginalValueAtCellX: cellX andCellY: cellY xIndex: x yIndex: y ] != 0 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)isPuzzleSolved
{
    return ([_sudokuModel isPuzzleSolved]);
}

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    return ([self._sudokuModel getOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    return ([self._sudokuModel getCurrentValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    [self._sudokuModel setCurrentValue:value atCellX:cellX andCellY:cellY xIndex:x yIndex:y];
}


@end
