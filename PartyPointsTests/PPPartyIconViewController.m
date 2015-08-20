//
//  PPPartyIconViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyIconViewController.h"
#import "PPPartyDateViewController.h"
#import "IconCollectionViewCell.h"

static NSString *iconViewCell = @"iconViewCell";

@interface PPPartyIconViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UICollectionView *iconCollectionView;

@property (strong, nonatomic) NSArray *iconList;

@end

@implementation PPPartyIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconCollectionView.dataSource = self;
    self.iconCollectionView.delegate = self;
    
    
    
    
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

- (NSArray *)iconList {
    
    NSMutableArray *icons = [NSMutableArray new];
    
    for (int i = 0; i <= 79; i++) {
        
        [icons addObject:[UIImage imageNamed:[NSString stringWithFormat:@"partyicon%d",i]]];

    }
    
    return icons;
    
}


#pragma mark - UICollectionView data source and delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iconViewCell forIndexPath:indexPath];
    
    cell.imageView.image = self.iconList[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.iconList.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.icon.image = self.iconList[indexPath.row];
    
    [self.icon reloadInputViews];
    
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
