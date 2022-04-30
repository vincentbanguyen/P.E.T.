import SwiftUI

@main
struct P_E_T_App: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var popOver: NSPopover!
    
    @MainActor func applicationDidFinishLaunching (_ notification: Notification) {
    
        statusItem = NSStatusBar.system.statusItem(withLength: 30)
        if let MenuButton = statusItem?.button {
            MenuButton.image = NSImage(systemSymbolName: "chart.line.uptrend.xyaxis.circle",
                                       accessibilityDescription: "P.E.T.")
            MenuButton.action = #selector(MenuButtonToggle)
        }
        
        self.popOver = NSPopover()
        self.popOver.contentSize = NSSize(width: 200, height: 300)
        self.popOver.behavior = .transient
        self.popOver.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func MenuButtonToggle() {
        if let button = statusItem?.button {
            if popOver.isShown {
                self.popOver.performClose(nil)
            } else {
                popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
