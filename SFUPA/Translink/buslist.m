//
//  buslist.m
//  Translink
//
//  Created by Mavis on 15-3-16.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//

#import "buslist.h"
#import "SearchController.h"

@interface BusController (){
    int bol;
    __weak IBOutlet UILabel *StopName;
}

@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UIView *FourthView;
@property (weak, nonatomic) IBOutlet UITextView *FirstScroll;
@property (weak, nonatomic) IBOutlet UITextView *SecondScroll;
@property (weak, nonatomic) IBOutlet UITextView *ThirdScroll;
@property (weak, nonatomic) IBOutlet UITextView *FourthScroll;
@property (weak, nonatomic) IBOutlet UIButton *Button145;
@property (weak, nonatomic) IBOutlet UIButton *Button135;
@property (weak, nonatomic) IBOutlet UIButton *Button144;
@property (weak, nonatomic) IBOutlet UIButton *Button143;
@property (weak, nonatomic) IBOutlet UITextField *searchtext;

@end

@implementation BusController

-(NSString*) makeRestAPICall : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = [[NSError alloc] init];
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    if(responseString == nil){
        NSLog(@"%i", 0);
        
    }
    else{
        NSLog(@"%i",1);
    }
    NSLog(@"resp:%@", responseString);
//    if(responseString == nil){
//        bol = 0;
//    }
//    else{
//        bol = 1;
//    }
    return responseString;
}

-(void)get145schedule:(NSString *)stop{
    NSString *MyUrl;
    if ([stop  isEqual: @"SFU Transit Exchange"]) {
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51861/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center(Up)"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51860/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51863/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"University High St"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/59044/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Science Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51862/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Campus Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51864/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    
    NSString *resp;
    NSString *route;
    NSString *firstneedle;
    NSString *secondneedle;
    NSInteger strCount;
    NSInteger Count;
    NSInteger index = 100;
    NSString *L1;
    NSString *L2;
    NSString *L3;
    NSString *L4;
    NSString *L5;
    NSString *L6;
    resp=[self makeRestAPICall: MyUrl];
    if (![resp containsString:@"</Message></Error>"]){
        if([stop isEqual:@"SFU Transit Exchange"]){
            route = [resp componentsSeparatedByString:@"<RouteNo>"][1];
            index=0;
        }
        else{
            NSString *sfind = @"<RouteNo>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:sfind withString:@""] length];
            Count /= [sfind length];
            NSString *temp;
            for (int i=0; i < Count+1; i++){
                temp = [resp componentsSeparatedByString:@"<RouteNo>"][i];
                NSLog (@"%@",temp);
                if ([temp containsString:@"145"]){
                    index=i;
                }
            }
            NSLog(@"index:%i",index);
            if (index < 5){
                route = [resp componentsSeparatedByString:@"<RouteNo>"][index];
            }
        }
        NSString *find = @"<ExpectedLeaveTime>";
        strCount = [route length] - [[route stringByReplacingOccurrencesOfString:find withString:@""] length];
        strCount /= [find length];
    }
    NSLog(@"strCount:%i", strCount);
    if (index > 10){
        strCount = 0;
    }
    
    if(strCount > 0){
        firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
        secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L1 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L1 = @"No Bus";
    }
    if(strCount > 1){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L2 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L2 = @"No Bus";
    }
    
    if(strCount > 2){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L3 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L3 = @"No Bus";
    }
    
    if(strCount > 3){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L4 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L4 = @"No Bus";
    }
    
    if(strCount > 4){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L5 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L5 = @"No Bus";
    }
    
    if(strCount > 5){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L6 = secondneedle;
        NSLog (@"%@",secondneedle);
    }
    else{
        L6 = @"No Bus";
    }
    self.FirstScroll.text = [NSString stringWithFormat: @"%@\t\t\t%@\t\t\t%@\n%@\t\t\t%@\t\t\t%@",L1,L2,L3,L4,L5,L6];
}

-(void)get135schedule:(NSString *)stop{
    NSString *MyUrl;
    if ([stop  isEqual: @"SFU Transit Exchange"]) {
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/53096/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center(Up)"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51860/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51863/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"University High St"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/59044/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Science Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51862/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Campus Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51864/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    
    NSString *resp;
    NSString *route;
    NSString *firstneedle;
    NSString *secondneedle;
    NSInteger strCount;
    NSInteger Count;
    NSInteger index=100;
    NSString *L1;
    NSString *L2;
    NSString *L3;
    NSString *L4;
    NSString *L5;
    NSString *L6;
    resp=[self makeRestAPICall: MyUrl];
    if (![resp containsString:@"</Message></Error>" ] && ![resp containsString:@"N35"]){
        if([stop isEqual:@"SFU Transit Exchange"]){
            route = [resp componentsSeparatedByString:@"<RouteNo>"][1];
            index = 0;
        }
        else{
            NSString *sfind = @"<RouteNo>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:sfind withString:@""] length];
            Count /= [sfind length];
            NSString *temp;
            for (int i=0; i < Count; i++){
                temp = [resp componentsSeparatedByString:@"<RouteNo>"][i];
                if ([temp containsString:@"135"]){
                    index=i;
                }
            }
            NSLog(@"%i",index);
            if (index < 5){
                route = [resp componentsSeparatedByString:@"<RouteNo>"][index];
            }
        }
        //NSLog(@"t:%@",route);
        NSString *find = @"<ExpectedLeaveTime>";
        strCount = [route length] - [[route stringByReplacingOccurrencesOfString:find withString:@""] length];
        strCount /= [find length];
    }
    if (index > 10){
        strCount = 0;
    }
    
    if(strCount > 0){
        firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
        secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L1 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L1 = @"No Bus";
    }
    if(strCount > 1){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L2 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L2 = @"No Bus";
    }
    
    if(strCount > 2){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L3 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L3 = @"No Bus";
    }
    
    if(strCount > 3){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L4 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L4 = @"No Bus";
    }
    
    if(strCount > 4){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L5 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L5 = @"No Bus";
    }
    
    if(strCount > 5){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L6 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L6 = @"No Bus";
    }
    self.SecondScroll.text = [NSString stringWithFormat: @"%@\t\t\t%@\t\t\t%@\n%@\t\t\t%@\t\t\t%@",L1,L2,L3,L4,L5,L6];
}

-(void)get144schedule:(NSString *)stop{
    NSString *MyUrl;
    if ([stop  isEqual: @"SFU Transit Exchange"]) {
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/52807/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center(Up)"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51860/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51863/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"University High St"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/59044/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Science Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51862/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Campus Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51864/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    
    NSString *resp;
    NSString *route;
    NSString *firstneedle;
    NSString *secondneedle;
    NSInteger strCount;
    NSInteger Count;
    NSInteger index=100;
    NSString *L1;
    NSString *L2;
    NSString *L3;
    NSString *L4;
    NSString *L5;
    NSString *L6;
    resp=[self makeRestAPICall: MyUrl];
    if (![resp containsString:@"</Message></Error>"]){
        NSLog(@"t:%@",stop);
        if([stop isEqual:@"SFU Transit Exchange"]){
            route = [resp componentsSeparatedByString:@"<RouteNo>"][1];
            index = 0;
        }
        else{
            NSString *sfind = @"<RouteNo>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:sfind withString:@""] length];
            Count /= [sfind length];
            NSString *temp;
            for (int i=0; i < Count; i++){
                temp = [resp componentsSeparatedByString:@"<RouteNo>"][i];
                if ([temp containsString:@"144"]){
                    index=i;
                }
            }
            NSLog(@"%i",index);
            if (index < 5){
                route = [resp componentsSeparatedByString:@"<RouteNo>"][index];
            }
        }
        NSString *find = @"<ExpectedLeaveTime>";
        strCount = [route length] - [[route stringByReplacingOccurrencesOfString:find withString:@""] length];
        strCount /= [find length];
    }
    if (index > 10){
        strCount = 0;
    }
    if(strCount > 0){
        firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
        //NSLog(@"a:%@",[route componentsSeparatedByString:@"<ExpectedLeaveTime>"][0]);
        secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L1 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L1 = @"No Bus";
    }
    if(strCount > 1){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L2 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L2 = @"No Bus";
    }
    
    if(strCount > 2){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L3 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L3 = @"No Bus";
    }
    
    if(strCount > 3){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L4 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L4 = @"No Bus";
    }
    
    if(strCount > 4){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L5 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L5 = @"No Bus";
    }
    
    if(strCount > 5){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L6 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L6 = @"No Bus";
    }
    self.ThirdScroll.text = [NSString stringWithFormat: @"%@\t\t\t%@\t\t\t%@\n%@\t\t\t%@\t\t\t%@",L1,L2,L3,L4,L5,L6];
    //NSLog (@"%@",self.ThirdScroll.text);
}

-(void)get143schedule:(NSString *)stop{
    NSString *MyUrl;
    if ([stop  isEqual: @"SFU Transit Exchange"]) {
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/52998/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center(Up)"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51860/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"SFU Transportation Center"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51863/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"University High St"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/59044/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Science Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51862/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    else if([stop  isEqual: @"Campus Rd"]){
        MyUrl =@"http://api.translink.ca/rttiapi/v1/stops/51864/estimates?apikey=ezVK3cAFTnCz2iCPSAVg";
    }
    
    NSString *resp;
    NSString *route;
    NSString *firstneedle;
    NSString *secondneedle;
    NSInteger strCount;
    NSInteger Count;
    NSInteger index;
    NSString *L1;
    NSString *L2;
    NSString *L3;
    NSString *L4;
    NSString *L5;
    NSString *L6;
    resp=[self makeRestAPICall: MyUrl];
    if (![resp containsString:@"</Message></Error>"]){
        if([stop isEqual:@"SFU Transit Exchange"]){
            route = [resp componentsSeparatedByString:@"<RouteNo>"][1];
        }
        else{
            NSString *sfind = @"<RouteNo>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:sfind withString:@""] length];
            Count /= [sfind length];
            NSString *temp;
            for (int i=0; i < Count; i++){
                temp = [resp componentsSeparatedByString:@"<RouteNo>"][i];
                if ([temp containsString:@"143"]){
                    index=i;
                }
            }
            if(index < 5){
                route = [resp componentsSeparatedByString:@"<RouteNo>"][index];
            }
        }
        NSString *find = @"<ExpectedLeaveTime>";
        strCount = [route length] - [[route stringByReplacingOccurrencesOfString:find withString:@""] length];
        strCount /= [find length];
    }
    
    if (index > 10){
        strCount = 0;
    }
    if(strCount > 0){
        firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
        secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L1 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L1 = @"No Bus";
    }
    if(strCount > 1){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L2 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L2 = @"No Bus";
    }
    
    if(strCount > 2){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L3 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L3 = @"No Bus";
    }
    
    if(strCount > 3){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L4 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L4 = @"No Bus";
    }
    
    if(strCount > 4){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L5 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L5 = @"No Bus";
    }
    
    if(strCount > 5){
        NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
        NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
        L6 = secondneedle;
        //NSLog (@"%@",secondneedle);
    }
    else{
        L6 = @"No Bus";
    }
    self.FourthScroll.text = [NSString stringWithFormat: @"%@\t\t\t%@\t\t\t%@\n%@\t\t\t%@\t\t\t%@",L1,L2,L3,L4,L5,L6];
    //NSLog (@"%@",self.FourthScroll.text);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchBus"]){
        SearchController *search =[segue destinationViewController];
        search.segueData = self.searchtext.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if(bol == 1){
        if(!self.segueData){
            return;
        }
        if([self.segueData isEqualToString:@"SFU Transit Exchange"]){
            self.segueData = nil;
            [self get145schedule:@"SFU Transit Exchange"];
            [self get135schedule:@"SFU Transit Exchange"];
            [self get144schedule:@"SFU Transit Exchange"];
            [self get143schedule:@"SFU Transit Exchange"];
            StopName.text = @"SFU Transit Exchange";
            [self.Button145 setTitle:@"145 (Bus#: 51861)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 53096)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 52807)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 52998)" forState:UIControlStateNormal];
        }
        else if ([self.segueData isEqualToString:@"SFU Transportation Center(Up)"]){
            self.segueData = nil;
            [self get145schedule:@"SFU Transportation Center(Up)"];
            [self get135schedule:@"SFU Transportation Center(Up)"];
            [self get144schedule:@"SFU Transportation Center(Up)"];
            [self get143schedule:@"SFU Transportation Center(Up)"];
            StopName.text = @"SFU Transportation Center(Up)";
            [self.Button145 setTitle:@"145 (Bus#: 51860)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 51860)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 51860)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 51860)" forState:UIControlStateNormal];
        }
        else if ([self.segueData isEqualToString:@"SFU Transportation Center"]){
            self.segueData = nil;
            [self get145schedule:@"SFU Transportation Center"];
            [self get135schedule:@"SFU Transportation Center"];
            [self get144schedule:@"SFU Transportation Center"];
            [self get143schedule:@"SFU Transportation Center"];
            StopName.text = @"SFU Transportation Center";
            [self.Button145 setTitle:@"145 (Bus#: 51863)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 51863)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 51863)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 51863)" forState:UIControlStateNormal];
        }
        else if ([self.segueData isEqualToString:@"University High St"]){
            self.segueData = nil;
            [self get145schedule:@"University High St"];
            [self get135schedule:@"University High St"];
            [self get144schedule:@"University High St"];
            [self get143schedule:@"University High St"];
            StopName.text = @"University High St";
            [self.Button145 setTitle:@"145 (Bus#: 59044)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 59044)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 59044)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 59044)" forState:UIControlStateNormal];
        }
        else if ([self.segueData isEqualToString:@"Science Rd"]){
            self.segueData = nil;
            [self get145schedule:@"Science Rd"];
            [self get135schedule:@"Science Rd"];
            [self get144schedule:@"Science Rd"];
            [self get143schedule:@"Science Rd"];
            StopName.text = @"Science Rd";
            [self.Button145 setTitle:@"145 (Bus#: 51862)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 51862)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 51862)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 51862)" forState:UIControlStateNormal];
        }
        else if ([self.segueData isEqualToString:@"Campus Rd"]){
            self.segueData = nil;
            [self get145schedule:@"Campus Rd"];
            [self get135schedule:@"Campus Rd"];
            [self get144schedule:@"Campus Rd"];
            [self get143schedule:@"Campus Rd"];
            StopName.text = @"Campus Rd";
            [self.Button145 setTitle:@"145 (Bus#: 51864)" forState:UIControlStateNormal];
            [self.Button135 setTitle:@"135 (Bus#: 51864)" forState:UIControlStateNormal];
            [self.Button144 setTitle:@"144 (Bus#: 51864)" forState:UIControlStateNormal];
            [self.Button143 setTitle:@"143 (Bus#: 51864)" forState:UIControlStateNormal];
        }
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
//                                                        message:@"⚠"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end