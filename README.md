

# Flow Insights 

> we need to document the current approach Flow uses to collect feedback from the Flow users and suppress certain tiles in case they click no thanks, etc

## User flow for tile feedback 

There are three feedback types the user can submit for a tile. 

- Bookmark
- Show more of these
- Show less of these 

To get to these the user follows the steps below:

1. Tap into the flow feed
2. See a flow tile 
3. On the top right of the tile there is an elipses button
4. Tap the elipses button 
5. A action sheet with 4 options appears 
   1. Share
   2. Bookmark
   3. Show more of these 
   4. Show less of these 
6. Choose your option 
7. A alert will appear (Feature Fake)
   1. "This feature isnt ready yet but were glad youre interested. keep clicking around so we know what you'd like to explore." 


## Current Implementation 

#### Current logic around tiles 

Currently we do not have any logic implemented that changes the users feed based on their feedback. 

#### How is the feed configured at the moment? 

The feed is currently configured based on the user account and the day of the week. 

All the logic on showing tiles is independent of the users feedback. 


#### We do track analytics based on the selection 

When the user taps on the selection we do track the feedback through our analytics 

Example analytics output or `Show more of these` 

```json 
"ReviewAdvertisement" : {
     "advertisement" : {
          "placementId" : "dailyexpensessummary",
          "targetScreenId" : "mobile_chase_ios_flow_feed",
          "status" : "adCustom",
          "interactionType" : "showMoreTap",
          "id" : "dailyexpensessummary",
          "uniformResourceLocator" : "dailyexpensessummary"
     }
}
```
Code for handling the selection of the action sheet. 

```objc 
    
[actionSheet addAction:[UIAlertAction actionWithTitle:@"Bookmark" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self featureFake];
        FlowAnalyticsEvent *event = [[FlowAnalyticsEvent alloc] initWithViewName: self.trimmedClassName subviewZone: @"ellipsesButton" action: @"bookmarkTap" duration:0];
        [JXPFlowAnalyticsAdapter handleEvent: event];
}]];
    
[actionSheet addAction:[UIAlertAction actionWithTitle:@"Show more of these" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self featureFake];
        FlowAnalyticsEvent *event = [[FlowAnalyticsEvent alloc] initWithViewName: self.trimmedClassName subviewZone: @"ellipsesButton" action: @"showMoreTap" duration:0];
        [JXPFlowAnalyticsAdapter handleEvent: event];
}]];
    
[actionSheet addAction:[UIAlertAction actionWithTitle:@"Show less of these" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self featureFake];
        FlowAnalyticsEvent *event = [[FlowAnalyticsEvent alloc] initWithViewName: self.trimmedClassName subviewZone: @"ellipsesButton" action: @"showLessTap" duration:0];
        [JXPFlowAnalyticsAdapter handleEvent: event];
}]]; 
```


## Video of Feedback 

