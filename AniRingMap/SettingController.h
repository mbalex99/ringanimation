//
//  SettingController.h
//  AniRingMap
//
//  Created by me on 23/1/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeveyPopListView;

@interface SettingController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UITextField*   mRingSizeField;
    IBOutlet UITextField*   mLoopDurationField;
    IBOutlet UITextField*   mRingColorField;
    IBOutlet UITextField*   mRingAmountField;
    IBOutlet UISwitch*      mShowHideSwitch;
    
    LeveyPopListView* mlplv;
}
@end
