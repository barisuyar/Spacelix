//
//  Launch+Hashable.swift
//  Spacelix
//
//  Created by BARIS UYAR on 9.03.2022.
//

extension Launch: Hashable {
    public static func == (lhs: LaunchListQuery.Data.Launch, rhs: LaunchListQuery.Data.Launch) -> Bool { lhs.id == rhs.id }
    public func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
