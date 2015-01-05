//
//  TimeTable.m
//  KWI Mobile
//
//  Created by Philipp Hadjimina on 24/12/14.
//  Copyright (c) 2014 Philipp Hadjimina. All rights reserved.
//

#import "TimeTable.h"
#import "Lessons.h"


@interface TimeTable ()

@end

@implementation TimeTable
@synthesize json;
@synthesize lesson_array;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void) parseData{
    
   //  lesson_mutablearray = [[NSMutableArray alloc] init];
    NSError* error;
    NSMutableArray *lesson_mutablearray = [[NSMutableArray alloc] init];
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* main_json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    for (id key in main_json) {
      // NSLog(@"key: %@, value: %@", key, [main_json objectForKey:key]);
    
        NSDictionary* day_json = [main_json objectForKey:key];
        
        if ([day_json isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray * day_json_array = [[NSMutableArray alloc] init];

            [day_json_array addObject:[main_json valueForKey:key ]];
            NSLog(@"logging %@",[day_json_array objectAtIndex:0]);
            
            
           
            for (int u = 0; u < [day_json_array count]; u++) {
                
                 NSMutableArray *room_subject_array =[day_json_array objectAtIndex:u];
               [lesson_mutablearray addObject:[[Lessons alloc]initWithJsonTime:u andwithArray:[room_subject_array objectAtIndex:u] andwithDate:key]];
                
            }
        }else{
            NSLog(@"asfdasdfasdfad");
            
            for (id daykey in day_json) {
                int lesson_nr = (int)[daykey integerValue];
                NSMutableArray *room_subject_arr =[day_json valueForKey:daykey];

                [lesson_mutablearray addObject:[[Lessons alloc]initWithJsonTime:lesson_nr andwithArray:room_subject_arr andwithDate:key]];
 
            }
     
        }
        lesson_array = lesson_mutablearray;
       
    }
    
  /*  for (int a = 0; a < [lesson_mutablearray count]; a++) {
        int b =[[lesson_mutablearray objectAtIndex:a] getLength];
    NSLog(@"lenght %d",b);
        
        if ( b >1) {
            for (int z = 0; z<b; z++) {
                 NSLog(@"subject %@", [[[lesson_mutablearray objectAtIndex:a] getSubject] objectAtIndex:z]);
                 NSLog(@"rooms %@", [[[lesson_mutablearray objectAtIndex:a] getRooms] objectAtIndex:z]);
                
            }
           
            
        }
        
    }*/
    
    
}



-(NSMutableArray*) getLesson{
    return lesson_array;
}
- (IBAction)OnClick:(id)sender {
    
    [self parseData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
