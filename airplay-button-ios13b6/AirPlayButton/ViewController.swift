import AVKit
import MediaPlayer
import UIKit

class ViewController: UIViewController {
    
    var detector: AVRouteDetector?
    
    // Setup 1:
    //   - Route picker view
    //
    // AirPlay icon after enabling a route:
    //   - iOS 11 - 12: Icon inactive.
    //   - iOS 13: Icon inactive.
    //
    // Comment:
    // For all iOS version, AVRoutePickerView state does not seem to be updated correctly if used alone.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let routePickerView = AVRoutePickerView.init(frame: .init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        routePickerView.translatesAutoresizingMaskIntoConstraints = false
        routePickerView.tintColor = .white
        self.view.addSubview(routePickerView)
        
        NSLayoutConstraint.activate([
            routePickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            routePickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
    }
    
#if false
    // Setup 2:
    //   - Route detector (always enabled here for simplicity).
    //   - Route picker view
    //
    // AirPlay icon after enabling a route:
    //   - iOS 11 - 12: Icon active.
    //   - iOS 13: Icon still inactive.
    //
    // Comment:
    // For iOS 11 - 12, AVRoutePickerView state seems to be updated correctly when a route detector is used. For iOS 13
    // this does not work.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detector = AVRouteDetector.init()
        self.detector?.isRouteDetectionEnabled = true
        
        let routePickerView = AVRoutePickerView.init(frame: .init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        routePickerView.translatesAutoresizingMaskIntoConstraints = false
        routePickerView.tintColor = .white
        self.view.addSubview(routePickerView)
        
        NSLayoutConstraint.activate([
            routePickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            routePickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
    }
#endif
    
#if false
    // Setup 3:
    //   - Route detector (always enabled here for simplicity).
    //   - Volume view (deprecated API).
    //
    // AirPlay icon after enabling a route:
    //   - iOS 11 - 12: Icon active.
    //   - iOS 13: Icon active
    //
    // Comment:
    // For iOS 11 - 12, AVRoutePickerView state seems to be updated correctly when a route detector is used. For iOS 13
    // this does not work. I feel that MPVolumeView plays the same role as the route detector in Setup 2 above.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let routePickerView = AVRoutePickerView.init(frame: .init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        routePickerView.translatesAutoresizingMaskIntoConstraints = false
        routePickerView.tintColor = .white
        self.view.addSubview(routePickerView)
        
        NSLayoutConstraint.activate([
            routePickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            routePickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
        
        let volumeView = MPVolumeView.init(frame: .zero)
        volumeView.translatesAutoresizingMaskIntoConstraints = false
        volumeView.showsRouteButton = true
        self.view.addSubview(volumeView)
        
        NSLayoutConstraint.activate([
            volumeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            volumeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            volumeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            volumeView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
#endif
}
