//
//  TimeTable.h
//  KWI Mobile
//
//  Created by Philipp Hadjimina on 24/12/14.
//  Copyright (c) 2014 Philipp Hadjimina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTable : UIViewController

@property(nonatomic)NSString *json;
@property(nonatomic)NSMutableArray *lesson_array;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
