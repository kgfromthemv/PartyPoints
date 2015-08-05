//
//  PPPartyNameViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyNameViewController.h"
#import "PPPartyIconViewController.h"

@interface PPPartyNameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) Party *party;

@end

@implementation PPPartyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (Party *)createParty {
    
    NSString *name = self.textField.text;
    
    self.party = [PartyController createPartyWithName:name];
    
    return self.party;
    
}

#pragma textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (self.party) {
        self.party.name = self.textField.text;
    } else {
        [self createParty];
    }
    
    PPPartyIconViewController *viewController = segue.destinationViewController;
    
    viewController.party = self.party;
    
    
}


@end
