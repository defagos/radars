//
//  ContainerViewController.h
//  ios5-root-container-bug
//
//  Created by Samuel Défago on 07.02.12.
//  Copyright (c) 2012 Samuel Défago. All rights reserved.
//

/**
 * Very basic implementation of a view controller container which does not automatically forward view lifecycle
 * and rotation events to its child view controllers. Here there are two view controllers, a bottom one and a
 * top one (this mimics a basic stack container implementation, similar to a UINavigationController with two
 * navigation levels). Forwarding of lifecycle events (here only viewWillAppear: and viewDidAppear: are events
 * of interest) is made manually in the container implementation.
 *
 * We expect that when such a container is set as root view controller of an application (or displayed modally),
 * only the top view controller receives viewWillAppear: and viewDidAppear: events when the application gets
 * displayed.
 *
 * To make the bug appearant, log statements have been added to the viewWillAppear: and viewDidAppear: method
 * implementations (including the stack trace). This way we can track when events are emitted, and by who.
 *
 * Workaround
 * ----------
 * I have found no easy workaround (except by swizzling all viewWillAppear: and viewDidAppear: methods of
 * UIViewController and its subclasses, which is rather unreliable). This bug makes any correct container
 * view controller implementation incorrect as of iOS 5.
 *
 * Expected application log
 * ------------------------
 *   - a single viewWillAppear: event for the top view controller when the application is about to be displayed
 *   - a single viewDidAppear: event for the top view controller when the application has been displayed
 *   - no viewWillAppear: or viewDidAppear: events for the bottom view controller
 *
 * Log obtained on iOS 4.3 (correct)
 * ---------------------------------
 * We obtain the results we expect
 *
 *   2012-02-07 20:37:21.153 ios5-root-container-bug[40308:b303] View will appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x00003001 -[ViewController viewWillAppear:] + 145
 *   1   ios5-root-container-bug             0x00002bd1 -[ContainerViewController viewWillAppear:] + 593                        <---- Expected: forwarded by the container
 *   2   UIKit                               0x000426a6 -[UIView(Hierarchy) _willMoveToWindow:withAncestorView:] + 207
 *   ...
 *   )
 *   2012-02-07 20:37:21.157 ios5-root-container-bug[40308:b303] View did appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x000030b1 -[ViewController viewDidAppear:] + 145
 *   1   ios5-root-container-bug             0x00002c68 -[ContainerViewController viewDidAppear:] + 136                         <---- Expected: forwarded by the container
 *   2   UIKit                               0x000c9fab -[UIViewController viewDidMoveToWindow:shouldAppearOrDisappear:] + 694
 *   3   UIKit                               0x0004ce4b -[UIView(Internal) _didMoveFromWindow:toWindow:] + 918
 *   ...
 *   )
 *
 * Log obtained on iOS 5 (incorrect)
 * ---------------------------------
 * Unexpected view lifecycle events are emitted:
 *   - a second viewWillAppear: / viewDidAppear: event is emitted
 *   - viewWillAppear: and viewDidAppear: are emitted for the bottom view controller
 * I interpret these results as follows: When view controller's views are displayed directly on UIWindow (no matter
 * where they are located in the view hierarchy), all of them automatically get viewWillAppear: / viewDidAppear:
 * events. The -automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers return value is not taken
 * into account when those views are themselves wrapped into another view.
 *
 *   2012-02-07 20:31:46.748 ios5-root-container-bug[40216:f803] View will appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x00003001 -[ViewController viewWillAppear:] + 145
 *   1   ios5-root-container-bug             0x00002bd1 -[ContainerViewController viewWillAppear:] + 593                    <---- Expected: forwarded by the container
 *   2   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   3   UIKit                               0x000d921b -[UIViewController __viewWillAppear:] + 62
 *   4   UIKit                               0x000da0f1 -[UIViewController viewWillMoveToWindow:] + 253
 *   ...
 *   )
 *   2012-02-07 20:31:46.904 ios5-root-container-bug[40216:f803] View will appear for Bottom; call stack: (
 *   0   ios5-root-container-bug             0x00003001 -[ViewController viewWillAppear:] + 145                             <---- Unexpected (incorrect automatic iOS 5 forwarding)
 *   1   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   2   UIKit                               0x000d921b -[UIViewController __viewWillAppear:] + 62
 *   3   UIKit                               0x000da0f1 -[UIViewController viewWillMoveToWindow:] + 253
 *   ...
 *   )
 *   2012-02-07 20:31:46.927 ios5-root-container-bug[40216:f803] View will appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x00003001 -[ViewController viewWillAppear:] + 145                             <---- Unexpected (incorrect automatic iOS 5 forwarding)
 *   1   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   2   UIKit                               0x000d921b -[UIViewController __viewWillAppear:] + 62
 *   3   UIKit                               0x000da0f1 -[UIViewController viewWillMoveToWindow:] + 253
 *   ...
 *   )
 *   2012-02-07 20:31:46.945 ios5-root-container-bug[40216:f803] View did appear for Bottom; call stack: (
 *   0   ios5-root-container-bug             0x000030b1 -[ViewController viewDidAppear:] + 145                              <---- Unexpected (incorrect automatic iOS 5 forwarding)
 *   1   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   2   UIKit                               0x000d92d4 -[UIViewController __viewDidAppear:] + 136
 *   ...
 *   )
 *   2012-02-07 20:31:46.948 ios5-root-container-bug[40216:f803] View did appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x000030b1 -[ViewController viewDidAppear:] + 145                              <---- Unexpected (incorrect automatic iOS 5 forwarding)
 *   1   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   2   UIKit                               0x000d92d4 -[UIViewController __viewDidAppear:] + 136
 *   ...
 *   )
 *   2012-02-07 20:31:46.951 ios5-root-container-bug[40216:f803] View did appear for Top; call stack: (
 *   0   ios5-root-container-bug             0x000030b1 -[ViewController viewDidAppear:] + 145
 *   1   ios5-root-container-bug             0x00002c68 -[ContainerViewController viewDidAppear:] + 136                     <---- Expected: forwarded by the container
 *   2   UIKit                               0x000d8fbf -[UIViewController _setViewAppearState:isAnimating:] + 158
 *   3   UIKit                               0x000d92d4 -[UIViewController __viewDidAppear:] + 136
 *   ...
 *   )
 *
 * How you should fix the bug
 * --------------------------
 * When a view controller is displayed as root view controller of an application (or modally), only its view must
 * receive viewWillAppear: and viewDidDisappear: events from UIKit internals. For view controller whose views have
 * been added as subviews of this root view controller, event forwarding must be made according to the value
 * returned by the -automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers method (as implemented
 * by the container view controller)
 *
 * Remarks
 * -------
 * This bug only occurs with containers displayed as root view controller of an application or modally. In all other
 * cases I considered (and there are a lot of them) the behavior is correct on iOS 5.
 *
 * For a complete container implementation, have a look at my implementations:
 *   https://github.com/defagos/CoconutKit
 * (classes HLSStackController and HLSContainerContent)
 * 
 */
@interface ContainerViewController : UIViewController {
@private
    UIViewController *m_bottomViewController;
    UIViewController *m_topViewController;
}

@property (nonatomic, retain) UIViewController *bottomViewController;
@property (nonatomic, retain) UIViewController *topViewController;

@end
