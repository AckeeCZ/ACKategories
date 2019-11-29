# Flow coordinators

ACKategories contains a basic [FlowCoordinator][flow-coordinator-impl] which should be parent of all your flow coordinators as it is capable of handling many complicated cases for you automatically.

We'll try to explain those cases in this documentation.

## Basics

Here we'll cover some basic of how flow coordinators should work.

### Starting a flow

Every flow coordinator needs to be started by some variant of `start(...)` method. If you're not starting any complicated flow, you're probably searching for basic `start()` method.

If you want your flow coordinator to handle some part of navigation inside `UINavigationController` you're searching for `start(with navigationController:)` method.

If you start by presenting a view controller modally, you're searching for `start(from viewController:)`.

Or you can add your own `start(...)` method but make sure you call super class method which is appropriate for your use case.

### Stopping a flow

Well as you have previously started a flow, you should also stop it some time. Basic cases of stopping a flow are handled automatically, others you'll have to handle yourself.

## ⚠️ Known limits

Well start with quick summary of known limits, if you're interested in more information

For handling multiple flow coordinators taking care of a single `UINavigationController` stack, we set its delegate, so you should count with that.

For handling interactive dismiss on iOS 13 we set the `presentationController.delegate` and we expect the `rootViewController` to be set when calling `super.start(from: viewController)` so you should also count with that.

#### Pop `rootViewController` from navigation stack

If you use more flow coordinators to handle your navigation stack inside `UINavigationController` you can get into situation that somewhere in the middle of your navigation stack, you start a new flow coordinator which takes current navigation stack and pushes a new controller. Well when that previously pushed view controller is popped you should `stop` its flow coordinator as it has nothing to manage.

This case is handled automatically as `FlowCoordinator` sets itself as delegate of that `UINavigationController` and observes changes to navigation stack, when coordinator's `rootViewController` is popped out of the navigation stack, it stops itself and sets its parent as new `UINavigationtionControllerDelegate`.

**⚠️ KNOWN LIMITS:** If you need to set your own `UINavigationControllerDelegate`, you can, but you have to take care of those cases yourself. It might be a good idea to look at the [FlowCoordinator implementation][flow-coordinator-impl] on how this can be done.

#### Interactive dismiss of iOS 13 modal view controller

Since iOS 13 the `pageSheet` modal presentation is default modal presentation style. As user can by default dismiss presented modal screen by dragging it towards the bottom edge of the screen, you can no longer rely that some of your callbacks (that surely handle stopping your flow coordinator correctly 😎) will be called.

When calling `start(from viewController:)` the `FlowCoordinator` sets itself as the `presentationController.delegate` and checks if the `rootViewController` has been interactively dismissed. This means that when calling `super.start(from: viewController)` the `rootViewController` needs to be already set, otherwise the observations wouldn't work.

**⚠️ KNOWN LIMITS:** If you need to set your own `presentationController.delegate`, you can, but you have to take care of those cases yourself. It might be a good idea to look at the [FlowCoordinator implementation][flow-coordinator-impl] on how this can be done.

[flow-coordinator-impl]: ../ACKategories/Base/FlowCoordinator.swift