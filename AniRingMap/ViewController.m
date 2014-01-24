//
//  ViewController.m
//  AniRingMap
//
//  Created by me on 23/1/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ViewController.h"
#import "SettingController.h"

#import "GlobalDef.h"

#define TIMER_TICK 0.5

@interface ViewController ()

@end

@implementation ViewController

#pragma - mark NSTimer Stuff

-(void)animatedRingTimer:(NSTimer*)timer
{
    [mMapView removeOverlays:mMapView.overlays];
    
    for (int i = 0; i < gRingAmounts; i++)
    {
        float radiusValue = [[mRadiusArray objectAtIndex:i] floatValue];
        CLLocationCoordinate2D coordinate = mMapView.userLocation.coordinate;
//        coordinate = CLLocationCoordinate2DMake(39.605688, -106.21582);
        MKCircle* circle = [MKCircle circleWithCenterCoordinate:coordinate radius:radiusValue];
        [mMapView addOverlay:circle];
        
        float nextRadius = radiusValue + gMaxRingSize * TIMER_TICK / gLoopDuration;
        
        if (nextRadius > gMaxRingSize) {
            nextRadius -= gMaxRingSize;
        }
        
        [mRadiusArray replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nextRadius]];
    }
}

#pragma - mark UIViewController functions redefinition

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([mAnimRingTimer isValid])
    {
        [mAnimRingTimer invalidate];
    }
    
    [mMapView removeOverlays:mMapView.overlays];
    
    if (gRingShow) {
        [self setInitialRadiusArray];
        mAnimRingTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_TICK target:self selector:@selector(animatedRingTimer:) userInfo:nil repeats:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(onGotoSetting)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark functions defined by me

-(void)setInitialRadiusArray
{
    mRadiusArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < gRingAmounts; i++)
    {
        [mRadiusArray addObject:[NSNumber numberWithFloat: i * gMaxRingSize / gRingAmounts]];
    }
}

-(void)onGotoSetting
{
    SettingController* settingController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingController"];
    [self.navigationController pushViewController:settingController animated:YES];
}

#pragma - mark MKMapView delegate

/*
-(MKOverlayView*)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
     if ([overlay class] == [MKCircle class])
     {
     MKCircle* circle = overlay;
     MKCircleView* circleView = [[MKCircleView alloc] initWithOverlay:overlay];
     circleView.strokeColor = [gRingColor colorWithAlphaComponent:2 * (0.5 - fabs(0.5 - circle.radius / gMaxRingSize))];
     circleView.fillColor = [UIColor clearColor];
     return circleView;
     }
     else
     return nil;
}
*/

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(10_9, 7_0)
{
    if ([overlay class] == [MKCircle class])
    {
        MKCircle* circle = overlay;
        MKCircleRenderer* circleRender = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleRender.strokeColor = [gRingColor colorWithAlphaComponent:2 * (0.5 - fabs(0.5 - circle.radius / gMaxRingSize))];
        circleRender.fillColor = [UIColor clearColor];
        return circleRender;
    }
    else
        return nil;
}

@end
