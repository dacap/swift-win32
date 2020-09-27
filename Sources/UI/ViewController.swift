/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class ViewController: Responder {
  /// Managing the View

  /// The view that the controller manages.
  public var view: View! {
    get {
      loadViewIfNeeded()
      return self.viewIfLoaded
    }
    set {
      // disconnect the view controller from the previous view
      self.viewIfLoaded?.viewController = nil

      // attach the view and view controller
      self.viewIfLoaded = newValue
      self.viewIfLoaded?.viewController = self
    }
  }

  /// The controller's view or `nil` if the view is not yet loaded.
  public private(set) var viewIfLoaded: View?

  /// Indicates if the view is loaded into memory.
  public var isViewLoaded: Bool {
    return self.viewIfLoaded == nil ? false : true
  }

  /// Creates the view that the controler manages.
  public func loadView() {
    // self.view = View(frame: .zero)
  }

  /// Called after the controller's view is loaded into memory.
  public func viewDidLoad() {
  }

  /// Loads the controller's view if it has not yet been loaded.
  public func loadViewIfNeeded() {
    guard !self.isViewLoaded else { return }
    self.loadView()
    self.viewDidLoad()
  }

  /// A localized string that represents the view this controller manages.
  public var title: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(view.hWnd)

#if swift(<5.3)
      let buffer: UnsafeMutablePointer<WCHAR> =
        UnsafeMutablePointer<WCHAR>.allocate(capacity: Int(szLength) + 1)
      defer { buffer.deallocate() }

      GetWindowTextW(view.hWnd, buffer, szLength + 1)
      return String(decodingCString: buffer, as: UTF16.self)
#else
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(view.hWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
#endif
    }
    set(value) {
      SetWindowTextW(view.hWnd, value?.LPCWSTR)
    }
  }

  /// The preferred size for the view controller's view.
  public var preferredContentSize: Size = .zero

  public override init() {
  }

  /// Presenting a View Controller

  /// Presents a view controller modally.
  public func present(_ controller: ViewController, animated: Bool,
                      completion: (() -> Void)? = nil) {
  }

  /// Getting Other Related View Controllers

  /// The view controller that presented this view controller.
  public private(set) var presentingViewController: ViewController?

  /// The view controller that is presented by this view controller, or one of
  /// its ancestors in the view controller hierarchy.
  public private(set) var presentedViewController: ViewController?

  // Responder Chain
  public override var next: Responder? {
    return view?.superview
  }
}

extension ViewController: ContentContainer {
  public func willTransition(to: Size,
                             with coodinator: ViewControllerTransitionCoordinator) {
  }

  public func willTransition(to: TraitCollection,
                             with coordinator: ViewControllerTransitionCoordinator) {
  }

  public func size(forChildContentContainer container: ContentContainer,
                   withParentContainerSize parentSize: Size) -> Size {
    return .zero
  }

  public func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer) {
  }

  public func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer) {
  }
}
