//
//  ViewController.h
//  Translink
//
//  Created by Mavis on 15-3-16.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Mavis
//
// Assignment 4:
// Edited by: | What was done?
// Mavis | Created

#import <UIKit/UIKit.h>

@interface TranController : UIViewController{
    
    __weak IBOutlet UISegmentedControl *segmentcontrol;
}

-(IBAction)clickNoFirst:(id)sender;
-(IBAction)clickNoSecond:(id)sender;
-(IBAction)clickNoThird:(id)sender;
-(IBAction)clickNoFourth:(id)sender;
-(IBAction)switchcontroller;

@end

