//
//  ViewController.h
//  KWI Mobile
//
//  Created by Philipp Hadjimina on 21/12/14.
//  Copyright (c) 2014 Philipp Hadjimina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate>{
@public NSString *jsondata;
}

@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progress ;

@property (strong, nonatomic) IBOutlet UIView *LoginView;

@property (weak, nonatomic) IBOutlet UISwitch *RememberMe;



@end

