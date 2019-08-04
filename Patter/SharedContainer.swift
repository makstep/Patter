//
//  SharedContainer.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import Swinject

extension Container {

    // Shared container
    static let sharedContainer: Container = {
        let container = Container()

        // VIPER builders

        PatterListInjectBuilder.registerVIPERComponents(in: container)
        PatterInjectBuiler.registerVIPERComponents(in: container)

        container.register(PatterListBuilder.self) { _ in PatterListInjectBuilder() }
        container.register(PatterBuilder.self) { _ in PatterInjectBuiler() }

        // Services

        container.register(RealmPatterEntityService.self) { (resolver, patterId) in
            RealmPatterEntityDefaultService(id: patterId, fileService: resolver.resolve(FileService.self)!)
        }
        container.register(AudioFilenameService.self) { _ in AudioFilenameTimestampService() }
        container.register(AudioPlayerService.self) { _ in AudioPlayerDefaultService() }
        container.register(AudioRecordingService.self) { resolver in
            AudioRecordingDefaultService(audioFilenameService: resolver.resolve(AudioFilenameService.self)!)
        }
        container.register(VibrationService.self) { _ in VibrationDefaultService() }
        container.register(FileService.self) { _ in FileDefaultService() }
        container.register(EnitiyOperationsService.self) { (resolver) in
            EnitiyOperationsDefaultService(fileService: resolver.resolve(FileService.self)!)
        }
        container.register(PatterListService.self) { _ in PatterListDefaultService() }

        return container
    }()

}
