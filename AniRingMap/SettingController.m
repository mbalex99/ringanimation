//
//  SettingController.m
//  AniRingMap
//
//  Created by me on 23/1/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "SettingController.h"
#import "LeveyPopListView.h"

float gMaxRingSize;
float gLoopDuration;
UIColor* gRingColor;
int gRingAmounts;
BOOL gRingShow;

@interface SettingController ()

@end

@implementation SettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mRingSizeField.text = [NSString stringWithFormat:@"%0.1f", gMaxRingSize];
    mLoopDurationField.text = [NSString stringWithFormat:@"%0.1f", gLoopDuration];
    mRingColorField.backgroundColor = gRingColor;
    mRingAmountField.text = [NSString stringWithFormat:@"%d", gRingAmounts];
    mShowHideSwitch.on = gRingShow;
    
    UIGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewWillDisappear:(BOOL)animated
{
    gMaxRingSize = mRingSizeField.text.floatValue;
    gLoopDuration = mLoopDurationField.text.floatValue;
    gRingColor = mRingColorField.backgroundColor;
    gRingAmounts = mRingAmountField.text.integerValue;
    gRingShow = mShowHideSwitch.on;
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark Gesture recognizer code

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [mlplv superview] != self.view)
    {
        return YES;
    }
    else
        return NO;
}

-(void)onTapView:(UIGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
}

#pragma - mark LeveyPopListView stuff

-(void)showColorList
{
    mlplv = [[LeveyPopListView alloc] initWithTitle:@"Choose color" options:[NSArray arrayWithObjects:@"Red", @"Green", @"Blue", nil] handler:^(NSInteger index) {
        
        switch (index) {
            case 0:
                mRingColorField.backgroundColor  = [UIColor redColor];
                break;
            case 1:
                mRingColorField.backgroundColor  = [UIColor greenColor];
                break;
            case 2:
                mRingColorField.backgroundColor  = [UIColor blueColor];
                break;
            default:
                break;
        }
    }];
    
    [mlplv showInView:self.view animated:YES];
}

#pragma - mark TextField Delegates

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == mRingColorField) {
        [self.view endEditing:YES];
        [self showColorList];
        return NO;
    }
    else
        return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end
