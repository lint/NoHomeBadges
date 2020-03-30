
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SBIconView : UIView
//ios 12
//@property(assign, nonatomic) NSInteger location;

//ios 13
//@property(strong, nonatomic) NSString *location;
@end

//ios 12
@interface SBFolderIconView : SBIconView
@end

%hook SBIconView

-(void) _createAccessoryViewIfNecessary{
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")){
		if ([MSHookIvar<NSString *>(self, "_iconLocation") isEqualToString:@"SBIconLocationFolder"]){
			%orig;
		}
	} else{
		if (MSHookIvar<NSInteger>(self, "_iconLocation") == 6){
			%orig;
		} 
	}
}

%end