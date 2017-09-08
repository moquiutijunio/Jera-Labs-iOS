//
//  ImageDownloadOperator.swift
//  Labs
//
//  Created by Junio Moquiuti on 08/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import Kingfisher
import RxSwift

extension ObservableType where E == URL? {
    func downloadImage(placeholder: UIImage? = nil, ignoreCache: Bool = false) -> Observable<UIImage?> {
        return flatMapLatest { imageURL -> Observable<UIImage?> in
            if let imageURL = imageURL {
                return Observable<UIImage?>.create({ (observer) -> Disposable in
                    var options = [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))]
                    if ignoreCache {
                        options.append(.forceRefresh)
                        
                        let modifier = AnyModifier { request in
                            var r = request
                            r.setValue("no-cache, no-store, must-revalidate", forHTTPHeaderField: "Cache-Control")
                            r.setValue("no-cache", forHTTPHeaderField: "Pragma")
                            r.setValue("0", forHTTPHeaderField: "Expires")
                            return r
                        }
                        
                        options.append(.requestModifier(modifier))
                    }
                    
                    let retrieveImageTask = KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString), options: options, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            observer.onError(error)
                        }
                        
                        if let image = image {
                            observer.onNext(image)
                            observer.onCompleted()
                        }
                    })
                    return Disposables.create {
                        retrieveImageTask.cancel()
                    }
                })
            }
            
            return Observable.just(placeholder)
        }
    }
}
