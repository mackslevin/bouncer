//
//  PhotosPickerManager.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import PhotosUI

class PhotosPickerManager: ObservableObject {
    enum ImageState {
        case empty, loading(Progress), success(Data), failure(Error)
    }
    
    @Published var imageState: ImageState = .empty
    
    @Published var backgroundImageSelection: PhotosPickerItem? {
        didSet {
            if let backgroundImageSelection {
                let progress = loadTransferable(from: backgroundImageSelection, imageType: .background)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    @Published var boxImageSelection: PhotosPickerItem? {
        didSet {
            if let boxImageSelection {
                let progress = loadTransferable(from: boxImageSelection, imageType: .boxImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    @Published var backgroundImageData: Data? = nil {
        didSet {
            Task {
                if let data = backgroundImageData {
                    await DataManager.shared.addUserImage(data: data, type: .background)
                }
            }
        }
    }
    
    @Published var boxImageData: Data? = nil {
        didSet {
            Task {
                if let data = boxImageData {
                    await DataManager.shared.addUserImage(data: data, type: .boxImage)
                }
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem, imageType: UserImage.ImageType) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                if imageType == .background {
                    guard imageSelection == self.backgroundImageSelection else { return }
                } else if imageType == .boxImage {
                    guard imageSelection == self.boxImageSelection else { return }
                } else {
                    fatalError("^^ Invalid image type")
                }
                
                switch result {
                case .success(let image?):
                    self.imageState = .success(image)
                    switch imageType {
                        case .background:
                            self.backgroundImageData = image
                        case .boxImage:
                            print("^^ Boxy")
                            self.boxImageData = image
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
