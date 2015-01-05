//
//  Lessons.m
//  KWI Mobile
//
//  Created by Philipp Hadjimina on 24/12/14.
//  Copyright (c) 2014 Philipp Hadjimina. All rights reserved.
//

#import "Lessons.h"

@implementation Lessons

-(NSMutableArray *)getRooms{
    return self.rooms;
}
-(NSMutableArray *)getSubject{
    return self.subjects;
}
-(int)getTimeIndex{
    return self.timeIndex;
}
-(int)getDay{
    return self.day;
}
-(int)getLength{
    return self.length;
}


-(id)initWithJsonTime:(int)time_index andwithArray:(NSMutableArray *)obj andwithDate:(NSString *)date
{
    self = [super init];
    
    if (self) {
        self.subjects = [NSMutableArray array];
        self.rooms = [NSMutableArray array];
        self.timeIndex =(int)[NSNumber numberWithInt:time_index];
        self.day =(int)[NSNumber numberWithInt:42];
        self.length = (int)[obj count];
    
    for (NSInteger j = 0; j<self.length; j++){
        
        NSDictionary* room_subject = [obj objectAtIndex:j];
        [self.rooms addObject:[[room_subject valueForKey:@"rooms"] objectAtIndex:0 ]];
        [self.subjects addObject:[room_subject objectForKey:@"subject"]];
       
        //INSERT "CHANGES" HERE
     
    }
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday  fromDate:today];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    //MONDAY
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 2)];
    NSDate *mo = [gregorian dateByAddingComponents:componentsToSubtract  toDate:today options:0];
    NSDateFormatter *mo_formatter = [[NSDateFormatter alloc] init];
    [mo_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *monday =[mo_formatter stringFromDate:mo];
    //TUESDAY
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 3)];
    NSDate *tu = [gregorian dateByAddingComponents:componentsToSubtract  toDate:today options:0];
    NSDateFormatter *tu_formatter = [[NSDateFormatter alloc] init];
    [tu_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *tuesday =[tu_formatter stringFromDate:tu];
    //WEDNESDAY
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 4)];
    NSDate *we = [gregorian dateByAddingComponents:componentsToSubtract  toDate:today options:0];
    NSDateFormatter *we_formatter = [[NSDateFormatter alloc] init];
    [we_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *wednesday =[tu_formatter stringFromDate:we];
    //THURSDAY
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 5)];
    NSDate *th = [gregorian dateByAddingComponents:componentsToSubtract  toDate:today options:0];
    NSDateFormatter *th_formatter = [[NSDateFormatter alloc] init];
    [th_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *thursday =[tu_formatter stringFromDate:th];
    //FRIDAY
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 6)];
    NSDate *fr = [gregorian dateByAddingComponents:componentsToSubtract  toDate:today options:0];
    NSDateFormatter *fr_formatter = [[NSDateFormatter alloc] init];
    [fr_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *friday =[fr_formatter stringFromDate:fr];
    
    if ([date isEqualToString:monday]) {
        self.day = 1;
    }
    else if ([date isEqualToString:tuesday]){
        self.day = 2;
    }
    else if ([date isEqualToString:wednesday]){
        self.day = 3;
    }
    else if ([date isEqualToString:thursday]){
        self.day = 4;
    }
    else if ([date isEqualToString:friday]){
        self.day = 5;
    }
    else{
        self.day = 6;
    }
    }
    NSLog(@"day %d",self.day);
   // NSLog(@"day %d",self.day);
    return self;
}

@end
