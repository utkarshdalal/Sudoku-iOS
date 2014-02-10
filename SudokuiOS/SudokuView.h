//
//  SudokuView.h
//  SudokuiOS
//
//  Created by Utkarsh Dalal on 11/20/13.
//  Copyright (c) 2013 Utkarsh Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SudokuViewController.h"

@interface SudokuView : UIView
{
    @private
    UInt32 _selectionCellX;
    UInt32 _selectionCellY;
    UInt32 _selectionX;
    UInt32 _selectionY;
    BOOL _haveSelection;
}

@property (weak) IBOutlet SudokuViewController* _viewController;

@end
