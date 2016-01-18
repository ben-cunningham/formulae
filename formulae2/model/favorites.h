#import <Foundation/Foundation.h>

@interface favorites : NSObject

- (void) addItem:(UIImage *) image;
- (UIImage *)getItemAtIndex:(int) index;
- (void) deleteItemAtIndex: (int) index;
- (void) viewAll;

@end
