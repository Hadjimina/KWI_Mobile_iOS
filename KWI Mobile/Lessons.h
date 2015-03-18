//
//  Lessons.h
//  KWI Mobile
//
//  Created by Philipp Hadjimina on 24/12/14.
//  Copyright (c) 2014 Philipp Hadjimina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lessons : NSObject

@property (nonatomic, strong)NSMutableArray *rooms;
@property (nonatomic, strong)NSMutableArray *subjects;
@property (nonatomic, assign)int timeIndex;
@property (nonatomic, assign)int day;
@property (nonatomic, assign)int length;

-(id) initWithJsonTime:(int)time_index andwithArray:(NSMutableArray*)obj andwithDate:(NSString*)date;
-(NSMutableArray*)getRooms;
-(NSMutableArray*)getSubject;
-(int)getTimeIndex;
-(int)getDay;
-(int)getLength;

@end
