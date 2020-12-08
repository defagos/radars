@import Foundation;

NS_ASSUME_NONNULL_BEGIN

OBJC_EXPORT void ObjCWithoutResourcesFunction(void);

@interface ObjCWithoutResources : NSObject

+ (void)classMethodOnObjCWithoutResources;
- (void)instanceMethodOnObjCWithoutResources;

@end

NS_ASSUME_NONNULL_END
