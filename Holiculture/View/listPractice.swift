//
//  listPractice.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/02.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List(0...100, id: \.self){ index in
            //view 넣기
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
