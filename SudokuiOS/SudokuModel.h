//
//  SudokuModel.h
//  Sudoku
//
//  Created by Utkarsh Dalal on 11/18/13.
//  Copyright (c) 2013 Utkarsh Dalal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuModel : NSObject

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY
                xIndex:(UInt32)x yIndex:(UInt32)y;

-( BOOL )isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                         xIndex:( UInt32 )x yIndex:( UInt32 )y;

-(BOOL)isPuzzleSolved;

+(SudokuModel*)sharedModel;

@end
