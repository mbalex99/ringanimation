//
//  ViewController.h
//  AniRingMap
//
//  Created by me on 23/1/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet MKMapView* mMapView;
    
    NSTimer* mAnimRingTimer;
    
    NSMutableArray* mRadiusArray;

}
@end
