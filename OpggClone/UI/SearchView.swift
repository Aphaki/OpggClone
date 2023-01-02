//
//  SearchView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchBarText: String
    var body: some View {
        VStack {
            SearchBar(searchBarText: $searchBarText)
                .padding(5)
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView(searchBarText: .constant(""))
        }
    }
}
