//
//  SudokuViewController.h
//  SudokuiOS
//
//  Created by Utkarsh Dalal on 11/20/13.
//  Copyright (c) 2013 Utkarsh Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuModel.h"
@class SudokuView;

@interface SudokuViewController : UIViewController

@property (assign, nonatomic) SudokuModel* _sudokuModel;

@property (strong) IBOutlet UIView *_sudokuView;

-(BOOL)isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                       xIndex:( UInt32 )x yIndex:( UInt32 )y;

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY
                xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isPuzzleSolved;

@end
