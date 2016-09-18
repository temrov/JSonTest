//
//  RecipeCollectionViewController.m
//  JSonTest
//
//  Created by user01 on 16.09.16.
//  Copyright © 2016 user01. All rights reserved.
//

#import "RecipeCollectionViewController.h"
#import "FCJSonRequest.h"
#import "FCImage.h"
#import <Foundation/Foundation.h>

@interface RecipeCollectionViewController()
@property (nonatomic) NSArray *recipeImages;
@end

@implementation RecipeCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    FCJSonRequest* req = [[FCJSonRequest alloc] init];
    [req configure];
    //RecipeCollectionViewController* weakSelf = self;
    [req loadItemsAtPath:FEATURED_ITEMS_PATH
               OnSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.recipeImages = mappingResult.array;
        [self.collectionView reloadData];
    }
               OnFailure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error getting pictures");
    }];
 
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recipeImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    FCImage* viewingElement = self.recipeImages[indexPath.row];
    NSURL* url = [[NSURL alloc] initWithString:viewingElement.url];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    recipeImageView.image = [[UIImage alloc] initWithData:imageData];
    
    return cell;
}
@end
