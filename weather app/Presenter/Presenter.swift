//
//  Presenter.swift
//  weather app
//
//  Created by Алексей Волобуев on 15.03.2023.
//

import Foundation
import CoreLocation
import UIKit

protocol ViewOutputDelegate: AnyObject {
    func getData()
}

class Presenter {
    var coordintes = [(String, CLLocationCoordinate2D)]()
    var secondViewSource = [SecondViewModel]()
    let session = URLSession.shared
    let decoder = JSONDecoder()
    weak private var viewInputDelegate: ViewInputDelegate?
    private var router: RouterDelegate?
    var source = ["Moscow", "Berlin", "London", "Madrid", "Dublin"]
    init(viewInput: ViewInputDelegate, router: Router) {
        self.viewInputDelegate = viewInput
        self.router = router
    }
    
    
    private func getCoordinates(completionHandler: (() -> ())?) {
        let dispatchGroup = DispatchGroup()
        for city in source {
            dispatchGroup.enter()
            CLGeocoder().geocodeAddressString(city) { (placemark, error) in
                if error == nil {
                    self.coordintes.append((city, (placemark?.first?.location!.coordinate)!))
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler?()
        }
    }
    
    private func getWeather(completionHandler: (([FirstViewModel]) -> Void)?) {
        var firstViewSource = [FirstViewModel]()
        let dispatchGroup = DispatchGroup()
        for coord in coordintes {
            dispatchGroup.enter()
            let link = "https://api.weather.yandex.ru/v2/forecast?lat=\(coord.1.latitude)&lon=\(coord.1.longitude)"
            print(link)
            guard let url = URL(string: link) else { return }
            var request = URLRequest(url: url)
            request.addValue("a4d577ab-9120-445f-8c59-ad98b2f8b83b", forHTTPHeaderField: "X-Yandex-API-Key")
            request.httpMethod = "GET"
            self.session.dataTask(with: request) { [weak self] (data, response, error) in
                //print(String(data: data!, encoding: .utf8) ?? "jopa")
                guard let strongSelf = self else { return }
                if error == nil, let parsData = data {
                    guard let resp = try? strongSelf.decoder.decode(Response.self, from: parsData) else {
                        print("jopa")
                        return }
                    guard let imUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(resp.fact.icon).svg") else { return }
                    var image = UIImage()
                    if let data = try? Data(contentsOf: imUrl) {
                        image = UIImage(data: data) ?? UIImage()
                    }
                    firstViewSource.append(FirstViewModel(name: coord.0, temp: resp.fact.temp, condition: resp.fact.condition, icon: image))
                    strongSelf.secondViewSource.append(SecondViewModel(name: coord.0, defPressureMm: resp.info.defPressureMm, pressureMm: resp.fact.pressureMm, temp: resp.fact.temp, feelsLike: resp.fact.feelsLike, icon: image, condition: resp.fact.condition, windSpeed: resp.fact.windSpeed, windDir: resp.fact.windDir, precType: resp.fact.precType))
                }
                dispatchGroup.leave()
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler?(firstViewSource)
        }
    }
}

extension Presenter: ViewOutputDelegate {
    func getData() {
        getCoordinates { [weak self] in
            self?.getWeather { [weak self] viewModel in
                self?.viewInputDelegate?.setupData(viewModel: viewModel)
            }
        }
    }
}
