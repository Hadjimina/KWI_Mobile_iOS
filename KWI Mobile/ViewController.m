
#import "ViewController.h"
#import "TimeTable.h"
#import "UIImage+ImageEffects.h"

#pragma mark NSURLConnection Delegate Methods


@interface ViewController (){
    NSMutableData *receivedData_;
    
}
@end


@implementation ViewController
@synthesize progress;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pwd.secureTextEntry = YES;
    
    UIImage *effectImage= nil;
   
    UIImage *blurbackgroundimage = [UIImage imageNamed:@"potato.png"];
   effectImage = [blurbackgroundimage applyBlurWithRadius:40
                                                             tintColor:[UIColor colorWithWhite:0.3 alpha:0.2]
                                                 saturationDeltaFactor:1.3
                                                             maskImage:nil];
    
  // effectImage = [blurbackgroundimage applyLightEffect];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* backView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backView.image = effectImage;
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:backView];
    
    progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    progress.center = CGPointMake(200, 568);
    progress.tag = 12;
    [self.view addSubview:progress];
    
    

    //REMEMBBER LOGIN
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *user = [def stringForKey:@"textField1Text"];
    NSString *pass = [def stringForKey:@"textField2Text"];
    self.username.text = user;
    self.pwd.text = pass;
    
    //REMEMBER TOGGLE STATE
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"stateOfSwitch"];
    if (value == nil) {
        self.RememberMe.on = NO;
    }
    else if ([value compare:@"ON"] == NSOrderedSame) {
        self.RememberMe.on = YES;
        
    } else {
        self.RememberMe.on = NO;
    }
    
    
   }

    


//ONCLICK AND CHECK IF INPUT VALID
- (IBAction)btnclick:(id)sender {

    NSString *name = self.username.text;
    NSString *password = self.pwd.text;
    
    //REMEMBER ME CHECK
    NSString *value = @"ON";
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    
    if(self.RememberMe.on == YES)
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString* textField1Text = self.username.text;
        [defaults setObject:textField1Text forKey:@"textField1Text"];
        
        NSString *textField2Text = self.pwd.text;
        [defaults setObject:textField2Text forKey:@"textField2Text"];
        [defaults synchronize];
        
        value =@"ON";
        [userPreferences setObject:value forKey:@"stateOfSwitch"];
        
    }
    else{
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString* textField1Text = @"Benutzername";
        [defaults setObject:textField1Text forKey:@"textField1Text"];
        
        NSString *textField2Text = @"Passwort";
        [defaults setObject:textField2Text forKey:@"textField2Text"];
        [defaults synchronize];
        
        value = @"OFF";
        [userPreferences setObject:value forKey:@"stateOfSwitch"];
        
    }
    
    //LOGIN
    if ([name isEqual:(@"Benutzername")]||[password isEqual:(@"Passwort")]) {
        
        UIAlertView *crederror = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:@"Sie müssen einen Benutzername und ein Passwort eingeben."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [crederror show];
    }
    else{
       [progress startAnimating];
        [self postrequest];
        
       
    }
 
   
}
-(void)setProgress:(UIActivityIndicatorView *)progress animated:(BOOL)animated{
    animated: YES;
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"login"]){
        TimeTable *tt = (TimeTable *)segue.destinationViewController;
        tt.json = jsondata;
    }
}

//RECIEVE DATA AND CHECK IF VALID
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [receivedData_ appendData:data];
    jsondata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@ jsondata",jsondata);
    
    if ([jsondata rangeOfString:@"error"].location != NSNotFound) {
        
        [progress stopAnimating];
        UIAlertView *crederror = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:@"Ihr Benutzername oder Passwort is falsch."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [crederror show];
    }
    else {
        
        [progress stopAnimating];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
  
}

//POSTREQUEST
-(void)postrequest{
    
    NSString *name = self.username.text;
    NSString *password = self.pwd.text;
    
    NSURL *url = [NSURL URLWithString:@"https://info.kwi.ch/s/timetable/api"];
    
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *namevaluepairs = [NSString stringWithFormat:@"username=%@&password=%@",name,password];
    [request setHTTPBody:[namevaluepairs dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request                                                                 delegate:self];
    
    [connection start];
    
}

//Text handling
- (IBAction)OnUsrEditBegin:(id)sender {
    if ([ self.username.text isEqual: (@"Benutzername")]) {
        self.username.text = @"";
    }
   
}
- (IBAction)OnUsrEditEnd:(id)sender {
    if ([ self.username.text isEqual: (@"")]) {
        self.username.text = @"Benutzername";
    }
}

- (IBAction)OnPwdEditBegin:(id)sender {
    if ([ self.pwd.text isEqual: (@"Passwort")]) {
        self.pwd.text = @"";
    }
    
}
- (IBAction)OnPwdEditEnd:(id)sender {
    if ([ self.pwd.text isEqual: (@"")]) {
        self.pwd.text = @"Passwort";
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end
