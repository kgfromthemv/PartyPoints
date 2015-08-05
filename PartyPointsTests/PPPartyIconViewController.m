//
//  PPPartyIconViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyIconViewController.h"
#import "PPPartyDateViewController.h"


@interface PPPartyIconViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation PPPartyIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Party *)updateParty {
    
    UIImage *image = self.icon.image;
    
    NSData *imageAsData = UIImageJPEGRepresentation(image, 0.0);
    
    self.party.icon = imageAsData;
    
    return self.party;
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSError *error;
    if (!error) {
        
        PPPartyDateViewController *viewController = segue.destinationViewController;
        
        viewController.party = [self updateParty];
        
    } else {
        
        NSLog(@"There has been an error:%@", error);
        
    }
    
}


@end
