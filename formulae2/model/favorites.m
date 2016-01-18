#import "favorites.h"

@implementation favorites

NSMutableArray* favoritesArray = Nil;


- (void) addItem:(UIImage *) image {
    
    [favoritesArray addObject:image];

}

- (UIImage *)getItemAtIndex:(int) index {
    
    return [favoritesArray objectAtIndex:index];
}

- (void) deleteItemAtIndex: (int) index {
    
    favoritesArray[index] = nil;
}

- (void) viewAll {
    
    for (int i = 0; i < favoritesArray.count; i++) {
        NSLog(@"%@", favoritesArray[i]);
    }
}


@end
