//
//  UIImage+LYBundle.m
//  Supermark
//
//  Created by 林伟池 on 15/9/14.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "UIImage+LYBundle.h"

@implementation UIImage (LYBundle)

+(UIImage*) imagesNamedFromCustomBundle:(NSString *)bundleName ImageName:(NSString*)imageName
{
    NSString* bundle = [bundleName stringByAppendingString:@"/images"];
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundle];
    
    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    
    NSString *image_path = [main_images_dir_path stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:image_path];
}

@end
