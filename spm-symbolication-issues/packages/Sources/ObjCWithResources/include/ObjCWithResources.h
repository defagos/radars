@import Foundation;

NS_ASSUME_NONNULL_BEGIN

OBJC_EXPORT void ObjCWithResourcesFunction(void);

@interface ObjCWithResources : NSObject

+ (void)classMethodOnObjCWithResources;
- (void)instanceMethodOnObjCWithResources;

@end

NS_ASSUME_NONNULL_END
