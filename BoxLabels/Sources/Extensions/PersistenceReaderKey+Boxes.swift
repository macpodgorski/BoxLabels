//
//  Untitled.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 12/08/2025.
//
import ComposableArchitecture

extension PersistenceReaderKey
where Self == PersistenceKeyDefault<FileStorageKey<IdentifiedArrayOf<Box>>> {
  static var boxes: Self {
    PersistenceKeyDefault(
      .fileStorage(.documentsDirectory.appending(component: "boxes.json")),
      []
    )
  }
}
